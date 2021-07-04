import 'package:flutter/material.dart';

import '../main.dart';
import '../models/executable_app.dart';
import 'executable_button.dart';

class ExecutableAppsList extends StatelessWidget {
  bool optionsAvailable;

  ExecutableAppsList({Key? key, required this.optionsAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(appsList);
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: appsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ExecutableButton(
                index: index,
                app: appsList[index],
                optionsAvailable: optionsAvailable),
          ),
        );
      },
    );
  }
}
