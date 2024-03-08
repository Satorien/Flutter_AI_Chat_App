import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 255, 251, 211), 
    onPrimary: Colors.black87,
    secondary: Color.fromARGB(255, 241, 251, 154), 
    onSecondary: Colors.black87,
    background: Colors.white10, 
    onBackground: Colors.black87,
    error: Colors.yellow,
    onError: Colors.black87,
    surface: Colors.white10,
    onSurface: Colors.black87,
    ),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 247, 247, 193),
    iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
  ),
);