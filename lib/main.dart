import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/firebase_info.dart';
import 'models/category.dart';
import 'pages/home_page.dart';
import 'route_generator.dart';
import 'utils/categories_storage.dart';
import 'bloc/apps_bloc.dart';

import 'models/executable_app.dart';
import 'pages/apps_page.dart';

CategoriesStorage categoriesStorage = CategoriesStorage();
List<Category> categoriesList = [];
bool isSync = false;

Future main() async {
  bool isAuthenticated = await firebaseAuthenticate();

  if (isAuthenticated) {
    await getCategoriesFromFirestore();
  } else {
    await getCategoriesFromLocalFile();
  }

  addEmptyCategoryIfNotExists();

  categoriesStorage.writeCategories(categoriesList);

  runApp(const DashboardAppsApp());
}

class DashboardAppsApp extends StatelessWidget {
  const DashboardAppsApp({Key? key}) : super(key: key);

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
