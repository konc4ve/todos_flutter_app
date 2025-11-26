import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/bootstrap.dart';
import 'package:todo/presentation/core/bloc/app_bloc_observer.dart';

import 'package:todo/data/services/todo_local_storage_service.dart';

void main() async {
  Bloc.observer = const AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final TodoLocalStorageService localStorageService = TodoLocalStorageService(
    plugin: prefs,
  );

  bootstrap(localStorageService: localStorageService);
}
