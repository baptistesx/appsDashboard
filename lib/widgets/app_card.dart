import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/apps_bloc.dart';
import '../models/executable_app.dart';
import 'app_form_dialog.dart';

class AppCard extends StatelessWidget {
  int categoryIndex;
  int appIndex;
  ExecutableApp app;
  bool optionsAvailable;

  AppCard(
      {Key? key,
      required this.categoryIndex,
      required this.appIndex,
      required this.app,
      required this.optionsAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(app.name),
            subtitle: optionsAvailable ? Text(app.path) : Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('EXECUTER'),
                  onPressed: () {
                    BlocProvider.of<AppsBloc>(context)
                        .add(LaunchExecuteApp(app: app));
                  },
                ),
                const SizedBox(width: 8),
                optionsAvailable
                    ? Row(
                        children: [
                          TextButton(
                            child: const Text('EDITER'),
                            onPressed: () {
                              _showAppDialog(
                                context,
                                categoryIndex,
                                appIndex,
                                app,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('SUPPRIMER'),
                            onPressed: () {
                              showConfirmActionDialog(context);
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
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
                      categoryValue: "TODO",
                      categoryIndex: categoryIndex,
                      appIndex: appIndex,
                      action: "DELETE_APP"));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAppDialog(BuildContext context, int? categoryIndex, int? appindex,
      ExecutableApp? app) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AppFormDialog(
            categoryIndex: categoryIndex, appIndex: appIndex, app: app);
      },
    );
  }
}
