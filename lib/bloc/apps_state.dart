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

abstract class SuccessActionState extends AppsState {
  final String message;

  SuccessActionState(this.message);
}

class AppLaunched extends SuccessActionState {
  AppLaunched(String message) : super(message);
}

class AppCreated extends SuccessActionState {
  AppCreated(String message) : super(message);
}

class AppDialogOpened extends AppsState {
  AppDialogOpened();
}

class AppDeleted extends SuccessActionState {
  AppDeleted(String message) : super(message);
}

class AppUpdated extends AppDeleted {
  AppUpdated(String message) : super(message);
}

class CategoryCreated extends SuccessActionState {
  CategoryCreated(String message) : super(message);
}

class CategoryUpdated extends AppDeleted {
  CategoryUpdated(String message) : super(message);
}
