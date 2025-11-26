import 'package:flutter/material.dart';

import 'package:todo/presentation/todos_overview/widgets/widgets.dart';

class TodosOverviewScreen extends StatelessWidget {
  const TodosOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TodosOverviewScreenView();
  }
}

class TodosOverviewScreenView extends StatelessWidget {
  const TodosOverviewScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TodosAppBar(),
      body: TodosStatusDragAndDropLists(),
    );
  }
}
