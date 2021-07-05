import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/category.dart';
import 'pages/home_page.dart';
import 'route_generator.dart';
import 'utils/categories_storage.dart';
import 'bloc/apps_bloc.dart';
import 'utils/apps_storage.dart';

import 'models/executable_app.dart';
import 'pages/apps_page.dart';

AppsStorage appsStorage = AppsStorage();
CategoriesStorage categoriesStorage = CategoriesStorage();
List<ExecutableApp> appsList = [];
List<Category> categoriesList = [];

Future main() async {
  await appsStorage.readEntities().then((List<ExecutableApp> value) {
    appsList = value;
  });

  await categoriesStorage.readEntities().then((List<Category> value) {
    categoriesList = value;
  });

  categoriesList.firstWhere((element) => element.name == "", orElse: () {
    categoriesList.add(Category(value: "", name: ""));
    return Category(value: "", name: "");
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
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
