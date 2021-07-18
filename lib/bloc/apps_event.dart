part of 'apps_bloc.dart';

@immutable
abstract class AppsEvent {
  AppsEvent([List props = const <dynamic>[]]);
}

class LaunchCreateApp extends AppsEvent {
  final ExecutableApp app;

  LaunchCreateApp({required this.app});
}

class LaunchExecuteApp extends AppsEvent {
  final ExecutableApp app;

  LaunchExecuteApp({required this.app});
}

class LaunchDeleteApp extends AppsEvent {
  final ExecutableApp app;

  LaunchDeleteApp({required this.app});
}

class LaunchUpdateApp extends AppsEvent {
  final int categoryIndex;
  final int appIndex;
  final String newName;
  final String newPath;
  final String newCategoryValue;

  LaunchUpdateApp({
    required this.categoryIndex,
    required this.appIndex,
    required this.newName,
    required this.newPath,
    required this.newCategoryValue,
  });
}

class LaunchOpenConfirmActionDialog extends AppsEvent {
  int appIndex;
  String action;
  String categoryValue;
  int categoryIndex;

  LaunchOpenConfirmActionDialog(
      {required this.categoryValue,
      required this.categoryIndex,
      required this.appIndex,
      required this.action});
}

class LaunchOpenAppDialog extends AppsEvent {
  LaunchOpenAppDialog();
}

class LaunchCreateCategory extends AppsEvent {
  final Category category;

  LaunchCreateCategory({required this.category});
}

class LaunchUpdateCategory extends AppsEvent {
  final int index;
  final Category category;

  LaunchUpdateCategory({required this.index, required this.category});
}
