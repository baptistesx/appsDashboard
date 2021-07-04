import 'package:flutter/material.dart';
import '../models/executable_app.dart';
import 'executable_button.dart';

class ExecutableAppsList extends StatelessWidget {
  List<ExecutableApp> apps;

  ExecutableAppsList({
    Key? key,
    required this.apps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: apps.length,
      itemBuilder: (BuildContext context, int index) {
        return ExecutableButton(app: apps[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
