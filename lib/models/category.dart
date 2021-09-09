import 'dart:convert';

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';

import '../main.dart';
import 'executable_app.dart';

class Category {
  String value;
  String name;
  List<ExecutableApp> apps;

  Category({required this.value, required this.name, required this.apps});

  // static Category fromSnapshot(Document snapshot) {
  //   return Category(
  //       value: snapshot.id,
  //       name: snapshot['email'],
  //       nome: snapshot['nome'],
  //       cognome: snapshot['cognome'],
  //       displayName: snapshot['displayName'],
  //       ruolo: snapshot['ruolo'],
  //       idSquadra: snapshot['idSquadra'],
  //       scadenzaCertificato: snapshot['scadenzaCertificato']);
  // }

  Map<String, dynamic> toMap() {
    return {'value': value, 'name': name, 'apps': apps};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    // map['apps']
    List<ExecutableApp> res = [];
    if (map['apps'].length > 0) {
      List list = map['apps'];
      res = list.map((e) => ExecutableApp.fromJson(e)).toList();
      print(res);
    }
    List<ExecutableApp> list = [
      ExecutableApp(name: "name", path: "path", categoryValue: "categoryValue")
    ];
    return Category(value: map['value'], name: map['name'], apps: res);
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(value: $value, name: $name, apps: $apps)';
}

// void addEmptyCategoryIfNotExists() {
//   categoriesList.firstWhere((element) => element.name == "", orElse: () {
//     categoriesList.add(Category(value: "", name: "", apps: []));
//     return Category(value: "", name: "", apps: []);
//   });
// }

Future<List<Category>> getCategoriesFromLocalFile() async {
  List<Category> categoriesFromLocalFile = [];

  print("pb connexion");
  //TODO try catch => Launch ErrorAppNotInitialized
  await categoriesStorage.readEntities().then((List<Category> value) {
    categoriesFromLocalFile = value;
  });

  //TODO add timer to try resync
  //Display icon to show app is not sync

  return categoriesFromLocalFile;
}

Future<List<Category>> getCategoriesFromFirestore() async {
  List<Category> categoriesListFromFirestore = [];
  // Instantiate a reference to a document - this happens offline
  var ref = Firestore.instance.collection('categories'); //.document('doc');

  // Subscribe to changes to that document
  // ref.stream.listen((cat) => print('updated: $cat'));

  // Update the document
  // await ref.update({'value': 'test'});

  // Get a snapshot of the document
  var categories = await ref.get();

  if (categories.length > 0) {
    categoriesListFromFirestore = categories.map((category) {
      List apps = category.map['apps'];
      List<ExecutableApp> executablesApps = apps
          .map((app) => ExecutableApp(
              name: app['name'], path: app['path'], categoryValue: category.id))
          .toList();

      Category cat = Category(
          value: category.id,
          name: category.map['name'],
          apps: executablesApps);

      return cat;
    }).toList();
  }

  isSync = true;
  print(categoriesListFromFirestore);
  return categoriesListFromFirestore;
}

Future<void> removeCategory(index) async {
  // categoriesList.firstWhere((element) => )
  // categoriesList.forEach((category) async {
  //   if (category.value != "") {
  //     var ref =
  //         Firestore.instance.collection('categories').document(category.value);

  //     await ref.update({
  //       'name': category.name,
  //       'apps': category.apps.map((e) => json.decode(e.toJson())).toList()
  //     });
  //   }
  // });
  // categoriesList = [];
  // await getCategoriesFromFirestore();
  // await categoriesStorage.writeCategories(categoriesList);
}

Future<void> createCategory() async {
  var ref = Firestore.instance.collection('categories');

  await ref.add(
      {'name': categoriesList[categoriesList.length - 1].name, 'apps': []});
  // categoriesList = [];

  categoriesList = List.from(await getCategoriesFromFirestore());
  await categoriesStorage.writeCategories(categoriesList);
}

Future<void> saveCategories() async {
  categoriesList.forEach((category) async {
    var ref =
        Firestore.instance.collection('categories').document(category.value);

    await ref.update({
      'name': category.name,
      'apps': category.apps.map((e) => json.decode(e.toJson())).toList()
    });
  });
  // categoriesList = [];
  categoriesList = List.from(await getCategoriesFromFirestore());
  await categoriesStorage.writeCategories(categoriesList);
}
