import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/domain/repositories/todos_repository.dart';
import 'package:todo/presentation/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todo/presentation/todos_overview/widgets/todos_overview_screen.dart';
import 'package:todo/presentation/core/theme/theme.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({required this.createTodosRepository, super.key});

  final TodosRepository Function() createTodosRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TodosRepository>(
      create: (_) => createTodosRepository(),
      dispose: (repository) => repository.dispose(),
      child: BlocProvider(
        create: (context) =>
            TodosOverviewBloc(todosRepository: context.read<TodosRepository>())..add(TodosOverviewSubscriptionRequested()),
        child: TodoAppView(),
      ),
    );
  }
}

class TodoAppView extends StatelessWidget {
  const TodoAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', 'RU')],
      locale: const Locale('ru', 'RU'),
      theme: TodosTheme.theme,
      home: TodosOverviewScreen(),
    );
  }
}
