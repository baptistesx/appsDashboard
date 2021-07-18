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
      categoriesList
          .firstWhere((e) => e.value == event.app.categoryValue)
          .apps
          .add(event.app);
      categoriesStorage.writeCategories(categoriesList);

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
        categoriesList[event.categoryIndex].apps.removeAt(event.appIndex);
        categoriesStorage.writeCategories(categoriesList);
        yield AppDeleted("App well deleted");
      }
      yield AppsInitial();
    }
    if (event is LaunchUpdateApp) {
      categoriesList[event.categoryIndex].apps[event.appIndex].name =
          event.newName;
      categoriesList[event.categoryIndex].apps[event.appIndex].categoryValue =
          event.newCategoryValue;
      categoriesList[event.categoryIndex].apps[event.appIndex].path =
          event.newPath;

      ExecutableApp app =
          categoriesList[event.categoryIndex].apps[event.appIndex];
      //TODO add app to the new cat
      categoriesList
          .firstWhere((element) => element.value == event.newCategoryValue)
          .apps
          .add(app);

      //TODO remove app from the old cat
      categoriesList[event.categoryIndex].apps.removeAt(event.appIndex);
      // ExecutableApp app = categoriesList
      //     .firstWhere((e) => e.value == event.app.categoryValue)
      //     .apps[event.index];
      // app.name = event.newName;
      // app.path = event.newPath;
      // app.categoryValue = event.newCategoryValue;
      categoriesStorage.writeCategories(categoriesList);

      yield AppUpdated("App well updated");
    }
    if (event is LaunchCreateCategory) {
      categoriesList.add(event.category);
      categoriesStorage.writeCategories(categoriesList);

      yield CategoryCreated("Category well created");
      yield AppsInitial();
    }
    if (event is LaunchUpdateCategory) {
      var appsList = categoriesList[event.index].apps.map((e) {
        e.categoryValue = event.category.value;
        return e;
      }).toList();
      // appsStorage.writeApps(appsList);

      categoriesList[event.index].apps = appsList;
      categoriesList[event.index].name = event.category.name;
      categoriesList[event.index].value = event.category.value;
      categoriesStorage.writeCategories(categoriesList);
      yield CategoryUpdated("Category well updated");
    }
    yield AppsInitial();
  }
}
