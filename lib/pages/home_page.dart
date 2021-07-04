import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/apps_bloc.dart';
import '../utils/apps_storage.dart';

import '../models/executable_app.dart';
import '../resources/globals.dart';
import '../widgets/executable_apps_list.dart';
import '../widgets/executable_button.dart';
import '../widgets/expandable_fab.dart';

import '../resources/globals.dart' as globals;

class HomePage extends StatelessWidget {
  String title;
  AppsStorage storage;

  HomePage({Key? key, required this.title, required this.storage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BlocConsumer<AppsBloc,AppsState>(listener: (context, state) {
          if (state is ErrorLaunchingApp) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 1),
              content: Row(children: [
                Icon(Icons.warning),
                SizedBox(width: 10),
                Text(state.message),
              ]),
              backgroundColor: Colors.red[400],
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is AppLaunched) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 1),
              content: Row(children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(state.message),
              ]),
              backgroundColor: Colors.green[400],
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is AppCreated) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 1),
              content: Row(children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(state.message),
              ]),
              backgroundColor: Colors.green[400],
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }, builder: (context, state) {
          return Center(child: ExecutableAppsList());
        }),
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
