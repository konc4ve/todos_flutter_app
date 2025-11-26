import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/edit_todo/bloc/edit_todo_bloc.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;
  const TitleField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditTodoBloc>();
    return TextField(
      controller: controller,
      onChanged: (value) => bloc.add(EditTodoTitleChanged(value)),
      decoration: const InputDecoration(labelText: "Задача"),
    );
  }
}