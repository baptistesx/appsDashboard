import 'dart:convert';
import 'dart:io';

import '../models/executable_app.dart';
import 'package:path_provider/path_provider.dart';

class AppsStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/apps.json');
  }

  Future<List<ExecutableApp>> readApps() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      // Map<String, dynamic> apps = jsonDecode(contents);
      // print(apps);

      var tagsJson = jsonDecode(contents) as List;
      List<ExecutableApp> tags = tagsJson
          .map((e) => ExecutableApp.fromJson(e))
          .toList(); //List.from(tagsJson) : [];

      return tags;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<File> writeApps(List<ExecutableApp> apps) async {
    final file = await _localFile;

    String appsListString = jsonEncode(apps);

    // Write the file
    return file.writeAsString('$appsListString');
  }
}
