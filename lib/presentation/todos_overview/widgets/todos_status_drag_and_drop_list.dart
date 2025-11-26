import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/todo.dart';
import 'package:todo/presentation/core/widgets/app_decorations.dart';


class TodosStatusDragAndDropList {
  static DragAndDropListExpansion build({
    required BuildContext context,
    required List<Todo> todos,
    required String title,
    required Function(Todo todo) onDelete,
  }) {
    final theme = Theme.of(context);

    return DragAndDropListExpansion(
      contentsWhenEmpty: Text('Список пуст'),
      trailing: Icon(Icons.expand_more),
      disableTopAndBottomBorders: true,
      listKey: ValueKey(title),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          Text('${todos.length}', style: theme.textTheme.titleMedium),
        ],
      ),
      canDrag: false,
      children: todos
          .map(
            (todo) => TodoDraggableItem.build(
              todo: todo,
              onDelete: () {
                showDialog(
                  context: context,
                  builder: (context) => GestureDetector(
                    onTap: () {
                      onDelete(todo);
                      
                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: AppDecorations.card,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              spacing: 5,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.delete_outlined),
                                Text('Удалить'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}

class TodoDraggableItem {
  static DragAndDropItem build({
    required Todo todo,
    required VoidCallback onDelete,
  }) {
    return DragAndDropItem(
      key: ValueKey(todo.id),
      child: GestureDetector(
        onTap: onDelete,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TodoCard(todo: todo),
        ),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: AppDecorations.card,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                const Icon(Icons.bookmark, color: Colors.red, size: 19),

                Expanded(
                  child: Text(todo.title, style: theme.textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              spacing: 5,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    const Icon(Icons.calendar_today, size: 19),
                    Text(
                      MaterialLocalizations.of(
                        context,
                      ).formatMediumDate(todo.completionDate),

                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),

                todo.isOverdue
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Просрочена',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      )
                    : Text('Hello'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
