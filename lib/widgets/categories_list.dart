import 'package:flutter/material.dart';

import '../models/category.dart';
import '../resources/globals.dart';

import '../main.dart';
import '../models/executable_app.dart';
import 'app_card.dart';

class CategoriesList extends StatefulWidget {
  bool optionsAvailable;

  CategoriesList({Key? key, required this.optionsAvailable}) : super(key: key);

  @override
  State<CategoriesList> createState() => _categoriesListListState();
}

class _categoriesListListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: categoriesList.length,
      itemBuilder: (BuildContext context, int index) {
        List<Padding> apps = _getAppsList(categoriesList[index]);

        return apps.length > 0
            ? CategoryExpansionCard(apps: apps, category: categoriesList[index])
            : Container();
      },
    );
  }

  List<Padding> _getAppsList(category) {
    List<ExecutableApp> list = appsList.where((i) {
      return i.categoryValue == category.value;
    }).toList();

    return list.map((e) {
      var index = list.indexOf(e);

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: AppCard(
              index: index,
              app: appsList[index],
              optionsAvailable: widget.optionsAvailable),
        ),
      );
    }).toList();
  }
}

class CategoryExpansionCard extends StatelessWidget {
  final List<Padding> apps;
  final Category category;

  CategoryExpansionCard({Key? key, required this.apps, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(
            title: Text(
              category.name,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: apps));
  }
}
