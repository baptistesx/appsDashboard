import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lachenal_app/pages/apps_page.dart';

import '../bloc/apps_bloc.dart';
import '../models/executable_app.dart';
import '../resources/globals.dart' as globals;
import '../resources/globals.dart';
import '../utils/apps_storage.dart';
import '../widgets/executable_apps_list.dart';
import '../widgets/executable_button.dart';
import '../widgets/expandable_fab.dart';

class HomePage extends StatelessWidget {
  HomePageParams data;

  HomePage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: BlocConsumer<AppsBloc, AppsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/apps',
                        arguments: AppsPageParams(
                            title:
                                "Apps")); // Navigate back to first screen when tapped.
                  },
                  child: Text('Etudiant'),
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/apps',
                        arguments: AppsPageParams(title: "Apps"));
                    // Navigate back to first screen when tapped.
                  },
                  child: Text('Professeur'),
                ),
              ],
            ));
          }),
      // floatingActionButton: CustomExpandableFab()
      // FloatingActionButton(
      //   onPressed: () {
      //     print("clicked");
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomePageParams {
  String title;

  HomePageParams({
    required this.title,
  });
}
