import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
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
      storage.writeApps(appsList);

      yield AppCreated("App well created");
      yield AppsInitial();
    }
    if (event is LaunchExecuteApp) {
      ProcessResult results = await Process.run(event.app.path, []);
      yield AppLaunched("App well launched");
      yield AppsInitial();
      // .catchError((e) => yield Error("error"));
    }
  }
}
