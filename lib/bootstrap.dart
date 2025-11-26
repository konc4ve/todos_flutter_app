import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/app/app.dart';

import 'package:todo/data/repositories/todos_repository_impl.dart';
import 'package:todo/data/services/todo_local_storage_service.dart';

import 'package:todo/presentation/core/bloc/app_bloc_observer.dart';

void bootstrap({required TodoLocalStorageService localStorageService}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  Bloc.observer = const AppBlocObserver();

  runApp(
    TodoApp(
      createTodosRepository: () =>
          TodosRepositoryImpl(localStorageService: localStorageService),
    ),
  );
}
