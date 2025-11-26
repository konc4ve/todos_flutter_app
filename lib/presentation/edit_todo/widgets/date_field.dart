import 'package:flutter/material.dart';

class EditTodoDateField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(DateTime) onDateSelected;

  const EditTodoDateField({
    required this.controller,
    required this.onDateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) onDateSelected(selectedDate);
      },
      decoration: const InputDecoration(
        labelText: "Дата завершения",
        suffixIcon: Icon(Icons.calendar_month),
      ),
    );
  }
}
