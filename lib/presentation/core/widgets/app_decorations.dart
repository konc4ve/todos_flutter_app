import 'package:flutter/material.dart';

class AppDecorations {
  static BoxDecoration card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        offset: Offset(2, 2),
        color: Colors.black.withAlpha(50),
        blurRadius: 4,
      ),
    ],
  );
}