import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/apps_bloc.dart';

import '../main.dart';
import '../models/executable_app.dart';
import 'app_form_dialog.dart';

class ExecutableButton extends StatelessWidget {
  int index;
  ExecutableApp app;
  bool optionsAvailable;

  ExecutableButton(
      {Key? key,
      required this.index,
      required this.app,
      required this.optionsAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
              textStyle: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              BlocProvider.of<AppsBloc>(context)
                  .add(LaunchExecuteApp(app: app));
            },
            child: Text(app.name)),
      ),
      optionsAvailable
          ? Positioned(
              top: 15,
              right: 15,
              child: PopupMenuButton(
                initialValue: 2,
                child: Center(child: Icon(Icons.more_vert)),
                itemBuilder: (context) {
                  var list = [
                    PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Edit"), Icon(Icons.edit)],
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Delete"), Icon(Icons.delete)],
                      ),
                      value: 2,
                    ),
                  ];
                  return list;
                },
                onSelected: (value) {
                  if (value == 1) {
                    _showAppDialog(context, index);
                  } else if (value == 2) {
                    showConfirmActionDialog(context);
                  }
                },
              ))
          : Container()
    ]);
  }

  void showConfirmActionDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Do you really want to execute this action?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');

              BlocProvider.of<AppsBloc>(context).add(
                  LaunchOpenConfirmActionDialog(
                      appIndex: index, action: "DELETE"));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAppDialog(BuildContext context, int? index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AppFormDialog(index: index);
      },
    );
  }
}
