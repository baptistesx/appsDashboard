import 'dart:io';

import 'package:flutter/material.dart';
import '../models/executable_app.dart';

class ExecutableButton extends StatelessWidget {
  ExecutableApp app;
  ExecutableButton({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          try {
            Process.run(app.path, []).then((ProcessResult results) {});
          } catch (e) {
            print(e);
          }
          print("clicked");
        },
        child: Text(app.name));
  }
}
