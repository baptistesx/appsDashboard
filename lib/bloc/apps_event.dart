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
