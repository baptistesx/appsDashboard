import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/apps_bloc.dart';
import 'utils/apps_storage.dart';

import 'models/executable_app.dart';
import 'pages/home_page.dart';

AppsStorage storage = AppsStorage();
List<ExecutableApp> appsList = [];

Future main() async {
  await storage.readApps().then((List<ExecutableApp> value) {
    appsList = value;
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AppsBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lachenal BTS Bois apps',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:
              HomePage(title: 'Lachenal BTS Bois apps', storage: AppsStorage()),
        ));
  }
}
