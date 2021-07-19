import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lachenal_app/models/category.dart';
import 'package:lachenal_app/utils/firebase_info.dart';

import '../bloc/apps_bloc.dart';
import '../main.dart';
import 'apps_page.dart';

class HomePage extends StatefulWidget {
  HomePageParams data;

  HomePage({Key? key, required this.data}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AppsBloc>(context).add(LaunchInitApp());

    return Scaffold(
      body: BlocConsumer<AppsBloc, AppsState>(
        listener: (context, state) {
          if (state is AppInitialized) {
            Navigator.pushNamed(context, '/apps',
                arguments: AppsPageParams(title: "Apps"));
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.data.title,
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 40),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomePageParams {
  String title;

  HomePageParams({
    required this.title,
  });
}
