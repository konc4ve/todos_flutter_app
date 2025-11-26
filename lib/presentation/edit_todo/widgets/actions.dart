import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/edit_todo/bloc/edit_todo_bloc.dart';

class EditTodoActions extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final ThemeData theme;

  const EditTodoActions({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 173, 179, 188),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Отменить",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: BlocBuilder<EditTodoBloc, EditTodoState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.isValid ? onSubmit : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: theme.primaryColor.withAlpha(102),
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Применить",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
