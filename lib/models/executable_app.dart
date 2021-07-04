import 'dart:convert';

class ExecutableApp {
  String name;
  String path;

  ExecutableApp(this.name, this.path);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
    };
  }

  factory ExecutableApp.fromMap(Map<String, dynamic> map) {
    return ExecutableApp(
      map['name'],
      map['path'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExecutableApp.fromJson(String source) => ExecutableApp.fromMap(json.decode(source));

  @override
  String toString() => 'ExecutableApp(name: $name, path: $path)';
}
