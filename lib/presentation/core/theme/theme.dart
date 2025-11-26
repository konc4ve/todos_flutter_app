import 'package:flutter/material.dart';

class TodosTheme {
  static ThemeData get theme => ThemeData(
    textTheme: TextTheme(
      titleMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color.fromARGB(255, 0, 125, 136),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: Colors.black),
      labelStyle: TextStyle(color: Color.fromARGB(255, 209, 213, 219)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: const Color.fromARGB(255, 0, 125, 136)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color.fromARGB(255, 209, 213, 219)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 0, 125, 136),
    ),
    primaryColor: const Color.fromARGB(255, 0, 125, 136),
  );
}
