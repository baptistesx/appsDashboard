import 'dart:async';

import 'package:firedart/firedart.dart';
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
// List<ExecutableApp> appsList = [];
List<Category> categoriesList = [];

// <!-- The core Firebase JS SDK is always required and must be listed first -->
// <script src="https://www.gstatic.com/firebasejs/8.7.1/firebase-app.js"></script>

// <!-- TODO: Add SDKs for Firebase products that you want to use
//      https://firebase.google.com/docs/web/setup#available-libraries -->

// <script>
//   // Your web app's Firebase configuration
//   var firebaseConfig = {
//     apiKey: "AIzaSyBKAWgzK2pGcsqxvJBRdJrmbC8RbipqsU8",
//     authDomain: "appsdashboard-91087.firebaseapp.com",
//     projectId: "appsdashboard-91087",
//     storageBucket: "appsdashboard-91087.appspot.com",
//     messagingSenderId: "1003078883847",
//     appId: "1:1003078883847:web:b1cd1495c9603a6a77a8a2"
//   };
//   // Initialize Firebase
//   firebase.initializeApp(firebaseConfig);
// </script>
const apiKey = 'AIzaSyBKAWgzK2pGcsqxvJBRdJrmbC8RbipqsU8';
const projectId = 'appsdashboard-91087';
const email = 'seuxbaptiste@gmail.com';
const password = 'testtest';

Future main() async {
  FirebaseAuth.initialize(apiKey, VolatileStore());
  Firestore.initialize(projectId); // Firestore reuses the auth client

  var auth = FirebaseAuth.instance;
  // Monitor sign-in state
  auth.signInState.listen((state) => print("Signed ${state ? "in" : "out"}"));

  // Sign in with user credentials
  await auth.signIn(email, password);

  // Get user object
  var user = await auth.getUser();
  // print(user);

// Instantiate a reference to a document - this happens offline
  var ref = Firestore.instance.collection('categories'); //.document('doc');

  // Subscribe to changes to that document
  // ref.stream.listen((cat) => print('updated: $cat'));

  // Update the document
  // await ref.update({'value': 'test'});

  // Get a snapshot of the document
  var categories = await ref.get();
  print(categories[0].id);
  categories.forEach((category) {
    List apps = category.map['apps'];
    List<ExecutableApp> executablesApps = apps
        .map((app) => ExecutableApp(
            name: app['name'], path: app['path'], categoryValue: category.id))
        .toList();
    print(apps);
    Category cat = Category(
        value: category.id, name: category.map['name'], apps: executablesApps);
    print(cat);

    categoriesList.add(cat);
  });
  print(categoriesList);
  // categoriesList =
  // await categoriesStorage.readEntities().then((List<Category> value) {
  //   categoriesList = value;
  // });

  // await categoriesStorage.readEntities().then((List<Category> value) {
  //   categoriesList = value;
  // });

  categoriesList.firstWhere((element) => element.name == "", orElse: () {
    categoriesList.add(Category(value: "", name: "", apps: []));
    return Category(value: "", name: "", apps: []);
  });
  // categoriesStorage.writeCategories(categoriesList);

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
