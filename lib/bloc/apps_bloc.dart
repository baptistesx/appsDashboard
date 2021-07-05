import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import '../models/category.dart';
import '../resources/globals.dart';
import '../models/executable_app.dart';
import 'package:meta/meta.dart';

import '../main.dart';

part 'apps_event.dart';
part 'apps_state.dart';

class AppsBloc extends Bloc<AppsEvent, AppsState> {
  AppsBloc() : super(AppsInitial());

  @override
  Stream<AppsState> mapEventToState(
    AppsEvent event,
  ) async* {
    if (event is LaunchCreateApp) {
      appsList.add(event.app);
      appsStorage.writeApps(appsList);

      yield AppCreated("App well created");
      yield AppsInitial();
    }
    if (event is LaunchExecuteApp) {
      try {
        ProcessResult results = await Process.run(event.app.path, []);
        yield AppLaunched("App well launched");
        yield AppsInitial();
      } on ProcessException catch (e) {
        yield ErrorLaunchingApp("Failed to launch app, check the pathfile");
        yield AppsInitial();
      }
    }
    if (event is LaunchOpenConfirmActionDialog) {
      if (event.action == "DELETE_APP") {
        appsList.removeAt(event.index);
        appsStorage.writeApps(appsList);
        yield AppDeleted("App well deleted");
      }
      yield AppsInitial();
    }
    if (event is LaunchUpdateApp) {
      appsList[event.index].name = event.newName;
      appsList[event.index].path = event.newPath;
      appsList[event.index].categoryValue = event.newCategoryValue;
      appsStorage.writeApps(appsList);

      yield AppUpdated("App well updated");
    }
    if (event is LaunchCreateCategory) {
      categoriesList.add(event.category);
      categoriesStorage.writeCategories(categoriesList);

      yield CategoryCreated("Category well created");
      yield AppsInitial();
    }
    if (event is LaunchUpdateCategory) {
      appsList = appsList.map((e) {
        if (e.categoryValue == categoriesList[event.index].value) {
          e.categoryValue = event.category.value;
        }
        return e;
      }).toList();
      appsStorage.writeApps(appsList);

      categoriesList[event.index].name = event.category.name;
      categoriesList[event.index].value = event.category.value;
      categoriesStorage.writeCategories(categoriesList);
      yield CategoryUpdated("Category well updated");
    }
    yield AppsInitial();
  }
}
