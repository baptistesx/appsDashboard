import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/apps_bloc.dart';

import '../models/executable_app.dart';

class ExecutableButton extends StatelessWidget {
  ExecutableApp app;
  ExecutableButton({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          BlocProvider.of<AppsBloc>(context).add(LaunchExecuteApp(app: app));
        },
        child: Text(app.name));
  }
}
