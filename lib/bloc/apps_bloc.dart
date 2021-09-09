import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firedart/firedart.dart';
import 'package:lachenal_app/utils/firebase_info.dart';
import '../models/category.dart';
import '../resources/globals.dart';
import '../models/executable_app.dart';
import 'package:meta/meta.dart';

import '../main.dart';

part 'apps_event.dart';
part 'apps_state.dart';

class AppsBloc extends Bloc<AppsEvent, AppsState> {
  AppsBloc() : super(AppNotInitialized());

  @override
  Stream<AppsState> mapEventToState(
    AppsEvent event,
  ) async* {
    if (event is LaunchInitApp) {
      if (!isAuthenticated) {
        isAuthenticated = await firebaseAuthenticate();
        // var ref = Firestore.instance.collection('categories');

        if (isAuthenticated) {
  categoriesList = List.from(await getCategoriesFromFirestore());
        } else {
  categoriesList = List.from(await getCategoriesFromLocalFile());
        }

        // addEmptyCategoryIfNotExists();

        categoriesStorage.writeCategories(categoriesList);
        yield AppNotInitialized();
        yield AppInitialized();
      }
    }
    if (event is LaunchCreateApp) {
      categoriesList
          .firstWhere((e) => e.value == event.app.categoryValue)
          .apps
          .add(event.app);

      await saveCategories();

      yield AppCreated("App well created");
      yield AppInitialized();
    }
    if (event is LaunchExecuteApp) {
      try {
        ProcessResult results = await Process.run(event.app.path, []);
        yield AppLaunched("App well launched");
        yield AppInitialized();
      } on ProcessException catch (e) {
        yield ErrorLaunchingApp("Failed to launch app, check the pathfile");
        yield AppInitialized();
      }
    }
    if (event is LaunchOpenConfirmActionDialog) {
      if (event.action == "DELETE_APP") {
        categoriesList[event.categoryIndex].apps.removeAt(event.appIndex);

        await saveCategories();

        yield AppDeleted("App well deleted");
      }
      yield AppInitialized();
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

      await saveCategories();

      yield AppUpdated("App well updated");
    }
    if (event is LaunchCreateCategory) {
      categoriesList.add(event.category);

      await createCategory();

      yield CategoryCreated("Category well created");
      yield AppInitialized();
    }
    if (event is LaunchUpdateCategory) {
      categoriesList[event.index].apps.forEach((e) {
        e.categoryValue = event.category.value;
      });
      // appsStorage.writeApps(appsList);

      // categoriesList[event.index].apps = appsList;
      categoriesList[event.index].name = event.category.name;
      categoriesList[event.index].value = event.category.value;
      await removeCategory(event.index);
      await saveCategories();

      yield CategoryUpdated("Category well updated");
    }
    yield AppInitialized();
  }
}
