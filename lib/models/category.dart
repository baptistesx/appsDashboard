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
  String toString() => 'Category(value: $value, name: $name)';
}

void addEmptyCategoryIfNotExists() {
  categoriesList.firstWhere((element) => element.name == "", orElse: () {
    categoriesList.add(Category(value: "", name: "", apps: []));
    return Category(value: "", name: "", apps: []);
  });
}

Future<void> getCategoriesFromLocalFile() async {
  print("pb connexion");
  //TODO try catch => Launch ErrorAppNotInitialized
  await categoriesStorage.readEntities().then((List<Category> value) {
    categoriesList = value;
  });

  //TODO add timer to try resync
  //Display icon to show app is not sync
}

Future<void> getCategoriesFromFirestore() async {
  // Instantiate a reference to a document - this happens offline
  var ref = Firestore.instance.collection('categories'); //.document('doc');

  // Subscribe to changes to that document
  // ref.stream.listen((cat) => print('updated: $cat'));

  // Update the document
  // await ref.update({'value': 'test'});

  // Get a snapshot of the document
  var categories = await ref.get();
  print(categories[0].id);
  categories.forEach((category) {
    List apps = category.map['apps'];
    List<ExecutableApp> executablesApps = apps
        .map((app) => ExecutableApp(
            name: app['name'], path: app['path'], categoryValue: category.id))
        .toList();
    print(apps);
    Category cat = Category(
        value: category.id, name: category.map['name'], apps: executablesApps);
    print(cat);

    categoriesList.add(cat);
  });

  isSync = true;
}
