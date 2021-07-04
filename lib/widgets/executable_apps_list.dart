import 'package:flutter/material.dart';

import '../main.dart';
import '../models/executable_app.dart';
import 'executable_button.dart';

class ExecutableAppsList extends StatelessWidget {
  ExecutableAppsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(appsList);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: appsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExecutableButton(app: appsList[index]),
        );
      },
    );
    // return ListView.separated(
    //   padding: const EdgeInsets.all(8),
    //   itemCount: appsList.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ExecutableButton(app: appsList[index]);
    //   },
    //   separatorBuilder: (BuildContext context, int index) => const Divider(),
    // );
  }
}
