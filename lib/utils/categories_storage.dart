import 'dart:convert';
import 'dart:io';

import '../models/category.dart';
import 'package:path_provider/path_provider.dart';

import '../models/executable_app.dart';

class CategoriesStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/categories.json');
  }

  Future<List<Category>> readEntities() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      var tagsJson = jsonDecode(contents) as List;
      List<Category> tags = tagsJson.map((e) => Category.fromJson(e)).toList();

      return tags;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<File> writeApps(List<Category> apps) async {
    final file = await _localFile;

    String appsListString = jsonEncode(apps);

    // Write the file
    return file.writeAsString('$appsListString');
  }
}
