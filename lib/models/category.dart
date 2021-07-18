import 'dart:convert';

import 'package:firedart/firestore/models.dart';
import 'package:lachenal_app/models/executable_app.dart';

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

ExecutableApp test() {
  return ExecutableApp(
      name: "name", path: "path", categoryValue: "categoryValue");
}
