import 'package:flutter/material.dart';

import '../models/executable_app.dart';
import '../resources/globals.dart';
import '../widgets/executable_apps_list.dart';
import '../widgets/executable_button.dart';
import '../widgets/expandable_fab.dart';

import '../resources/globals.dart' as globals;

class HomePage extends StatelessWidget {
  String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: ExecutableAppsList(apps: globals.appsList)),
        floatingActionButton: CustomExpandableFab()
        // FloatingActionButton(
        //   onPressed: () {
        //     print("clicked");
        //   },
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
