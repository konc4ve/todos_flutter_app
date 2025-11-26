import 'package:flutter/material.dart';
import 'package:todo/presentation/edit_todo/widgets/bottom_sheet.dart';

class TodosAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TodosAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.white,
  
      title: const Text('Todo'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: theme.primaryColor,
              child: InkWell(
                onTap: () {
                  showEditTodoBottomSheet(context);
                },
                child: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
