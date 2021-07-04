import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/apps_bloc.dart';
import '../models/executable_app.dart';
import '../resources/globals.dart' as globals;
import '../resources/globals.dart';
import '../utils/apps_storage.dart';
import '../widgets/executable_apps_list.dart';
import '../widgets/executable_button.dart';
import '../widgets/expandable_fab.dart';

class AppsPage extends StatefulWidget {
  AppsPageParams data;

  AppsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  String dropdownValue = 'One';
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.data.title), actions: [
          Row(
            children: [
              Text("Administrateur"),
              Switch(
                value: isAdmin,
                onChanged: (value) {
                  setState(() {
                    isAdmin = value;
                    print(isAdmin);
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
        ]),
        body: BlocConsumer<AppsBloc, AppsState>(listener: (context, state) {
          var snackBar;

          if (state is ErrorLaunchingApp) {
            snackBar = SnackBar(
              duration: const Duration(seconds: 1),
              content: Row(children: [
                Icon(Icons.warning),
                SizedBox(width: 10),
                Text(state.message),
              ]),
              backgroundColor: Colors.red[400],
            );
          } else if (state is SuccessActionState) {
            snackBar = SnackBar(
              duration: const Duration(seconds: 1),
              content: Row(children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(state.message),
              ]),
              backgroundColor: Colors.green[400],
            );
          }

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }, builder: (context, state) {
          return Center(child: ExecutableAppsList(optionsAvailable: isAdmin));
        }),
        floatingActionButton: isAdmin ? CustomExpandableFab() : Container());
  }
}

class AppsPageParams {
  String title;
  // AppsStorage storage;

  AppsPageParams({
    required this.title,
    // required this.storage,
  });
}
