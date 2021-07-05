// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lachenal_app/bloc/apps_bloc.dart';
import 'package:lachenal_app/main.dart';
import 'package:lachenal_app/models/executable_app.dart';
import 'package:lachenal_app/resources/globals.dart';

class PinCodeFormDialog extends StatefulWidget {
  const PinCodeFormDialog({Key? key}) : super(key: key);

  @override
  PinCodeFormDialogState createState() {
    return PinCodeFormDialogState();
  }
}

class PinCodeFormDialogState extends State<PinCodeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  var pinCodeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pinCodeController.dispose();
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
            Text("Please enter the pin code"),
            TextFormField(
              controller: pinCodeController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty || value.length != 4) {
                  return 'Please enter the pin code';
                } else if (value != "1234") {
                  return 'Bad pin code';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "Pin Code"),
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
              Navigator.of(context).pop(true);
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
    // Build a Form widget using the _formKey created above.
  }
}
