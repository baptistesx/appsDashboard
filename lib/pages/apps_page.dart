import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/categories_list.dart';
import '../widgets/pin_code_form_dialog.dart';

import '../bloc/apps_bloc.dart';
import '../models/executable_app.dart';
import '../resources/globals.dart' as globals;
import '../resources/globals.dart';
import '../utils/apps_storage.dart';
import '../widgets/app_card.dart';
import '../widgets/expandable_fab.dart';

class AppsPage extends StatefulWidget {
  AppsPageParams data;

  AppsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  String dropdownValue = 'One';
  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.data.title), actions: [
          Row(
            children: [
              Text("Administrateur"),
              Switch(
                value: isAdmin,
                onChanged: (isOn) {
                  if (isOn) {
                    showPinCodeDialog(context);
                  } else {
                    setState(() {
                      isAdmin = false;
                    });
                  }
                  // open dialog
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
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }, builder: (context, state) {
          return CategoriesList(optionsAvailable: isAdmin);
        }),
        floatingActionButton: BlocBuilder<AppsBloc, AppsState>(
          builder: (context, state) {
            return isAdmin ? CustomExpandableFab() : Container();
          },
        ));
  }

  void showPinCodeDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return PinCodeFormDialog();
      },
    ).then((valueFromDialog) {
      if (valueFromDialog == true) {
        setState(() {
          isAdmin = true;
        });
      }
    });
    ;
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
