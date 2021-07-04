part of 'apps_bloc.dart';

@immutable
abstract class AppsState {
  AppsState([List props = const <dynamic>[]]);
}

class AppsInitial extends AppsState {}

class ErrorLaunchingApp extends AppsState {
  final String message;

  ErrorLaunchingApp(this.message);
}

class AppLaunched extends AppsState {
  final String message;

  AppLaunched(this.message);
}

class AppCreated extends AppsState {
  final String message;

  AppCreated(this.message);
}
