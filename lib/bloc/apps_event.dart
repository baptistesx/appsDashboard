part of 'apps_bloc.dart';

@immutable
abstract class AppsEvent {
  AppsEvent([List props = const <dynamic>[]]);
}

class LaunchCreateApp extends AppsEvent {
  final ExecutableApp app;

  LaunchCreateApp(this.app);
}

class CreateAppParams {
  String name = "";
  String path = "";
  CreateAppParams({
    required this.name,
    required this.path,
  });
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
  final int index;
  final String newName;
  final String newPath;

  LaunchUpdateApp(
      {required this.index, required this.newName, required this.newPath});
}

class LaunchOpenConfirmActionDialog extends AppsEvent {
  int appIndex;
  String action;

  LaunchOpenConfirmActionDialog({required this.appIndex, required this.action});
}

class LaunchOpenAppDialog extends AppsEvent {
  LaunchOpenAppDialog();
}
