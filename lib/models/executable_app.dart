import 'dart:convert';

class ExecutableApp {
  String name;
  String path;
  String categoryValue;

  ExecutableApp(
      {required this.name, required this.path, required this.categoryValue});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
      'categoryValue': categoryValue,
    };
  }

  factory ExecutableApp.fromMap(Map<String, dynamic> map) {
    print(map);
    print(map["name"]);
    print(map["name"] is String);
    return ExecutableApp(
      name: map['name'],
      path: map['path'],
      categoryValue: map['categoryValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExecutableApp.fromJson(String source) =>
      ExecutableApp.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExecutableApp(name: $name, path: $path, categoryValue: $categoryValue)';
}
