import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final VoidCallback onCancel;
  const Header({required this.onCancel, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Создание задачи", style: TextStyle(fontSize: 24)),
        IconButton(icon: const Icon(Icons.close), onPressed: onCancel),
      ],
    );
  }
}
