import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/presentation/core/widgets/app_decorations.dart';
import 'package:todo/presentation/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todo/presentation/todos_overview/widgets/todos_status_drag_and_drop_list.dart';

class TodosStatusDragAndDropLists extends StatelessWidget {
  const TodosStatusDragAndDropLists({super.key});

  @override
  Widget build(BuildContext context) {

    void handleDelete(Todo todo) {
      context.read<TodosOverviewBloc>().add(TodosOverviewTodoDeleted(todo));
      Navigator.pop(context);
    }

    return BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
      builder: (context, state) {
        return DragAndDropLists(
          listPadding: const EdgeInsets.only(right: 8, left: 8, top: 8),
          listDecoration: AppDecorations.card,
          listGhost: const SizedBox.shrink(),
          children: [
            TodosStatusDragAndDropList.build(
              context: context,
              todos: state.toBeCompleted,
              title: "К выполнению",
              onDelete: handleDelete,
            ),
            TodosStatusDragAndDropList.build(
              context: context,
              todos: state.inProgress,
              title: "В работе",
              onDelete: handleDelete,
            ),
            TodosStatusDragAndDropList.build(
              context: context,
              todos: state.underReview,
              title: "На проверке",
              onDelete: handleDelete,
            ),
            TodosStatusDragAndDropList.build(
              context: context,
              todos: state.completed,
              title: "Выполнено",
              onDelete: handleDelete,
            ),
          ],
          onItemReorder:
              (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {
                context.read<TodosOverviewBloc>().add(
                  TodosOverviewTodoMoved(
                    oldItemIndex: oldItemIndex,
                    oldListIndex: oldListIndex,
                    newItemIndex: newItemIndex,
                    newListIndex: newListIndex,
                  ),
                );
              },
          onListReorder: (oldListIndex, newListIndex) {},
        );
      },
    );
  }
}
