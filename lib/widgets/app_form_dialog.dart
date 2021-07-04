// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lachenal_app/bloc/apps_bloc.dart';
import 'package:lachenal_app/main.dart';
import 'package:lachenal_app/models/executable_app.dart';
import 'package:lachenal_app/resources/globals.dart';

class AppFormDialog extends StatefulWidget {
  final int? index;

  const AppFormDialog({Key? key, required this.index}) : super(key: key);

  @override
  AppFormDialogState createState() {
    return AppFormDialogState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AppFormDialogState extends State<AppFormDialog> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var pathController = TextEditingController();
  bool isCreateDialog = true;

  @override
  void initState() {
    super.initState();

    if (widget.index != null) {
      nameController =
          new TextEditingController(text: appsList[widget.index!].name);
      pathController =
          new TextEditingController(text: appsList[widget.index!].path);
    }

    isCreateDialog = widget.index == null;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    pathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isCreateDialog ? Text("Add a new app") : Text("Edit the app"),
            TextFormField(
              controller: nameController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the app name';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "App Name"),
            ),
            TextFormField(
              controller: pathController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the app path';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "App path"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CLOSE'),
        ),
        ElevatedButton(
          onPressed: () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              if (isCreateDialog) {
                BlocProvider.of<AppsBloc>(context).add(LaunchCreateApp(
                    ExecutableApp(nameController.text, pathController.text)));
              } else {
                BlocProvider.of<AppsBloc>(context).add(LaunchUpdateApp(
                    index: widget.index!,
                    newName: nameController.text,
                    newPath: pathController.text));
              }

              // appsList.add(ExecutableApp(, path))
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              Navigator.of(context).pop();
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
    // Build a Form widget using the _formKey created above.
  }
}
