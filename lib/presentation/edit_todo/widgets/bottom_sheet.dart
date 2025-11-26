import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/repositories/todos_repository.dart';
import 'package:todo/presentation/edit_todo/bloc/edit_todo_bloc.dart';
import 'package:todo/presentation/edit_todo/widgets/widgets.dart';

void showEditTodoBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BlocProvider(
        create: (_) =>
            EditTodoBloc(todosRepository: context.read<TodosRepository>()),
        child: const _EditTodoModal(),
      );
    },
  );
}

class _EditTodoModal extends StatefulWidget {
  const _EditTodoModal();

  @override
  State<_EditTodoModal> createState() => _EditTodoModalState();
}

class _EditTodoModalState extends State<_EditTodoModal> {
  late final EditTodoBloc _editBloc;
  late final TextEditingController _titleController;
  late final TextEditingController _dateController;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _editBloc = context.read<EditTodoBloc>();
    _titleController = TextEditingController();
    _dateController = TextEditingController();

    _subscription = _editBloc.stream.listen((state) {
      _titleController.text = state.title;
      _dateController.text = state.completionDate != null
          ? DateFormat('yyyy-MM-dd').format(state.completionDate!)
          : '';
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    _editBloc.add(EditTodoSubmitted());
    Navigator.pop(context);
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final heightFactor = keyboardHeight > 0 ? 0.5 : 0.33;
    final theme = Theme.of(context);

    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Header(onCancel: _handleCancel),

                TitleField(controller: _titleController),
                const SizedBox(height: 12),
                EditTodoDateField(
                  controller: _dateController,
                  onDateSelected: (date) =>
                      _editBloc.add(EditTodoCompletionDateChanged(date)),
                ),
                const SizedBox(height: 16),
                EditTodoActions(
                  onCancel: _handleCancel,
                  onSubmit: _handleSubmit,
                  theme: theme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
