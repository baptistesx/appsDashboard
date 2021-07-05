import 'dart:convert';

class Category {
  String value;
  String name;

  Category({
    required this.value,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      value: map['value'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(value: $value, name: $name)';
}
