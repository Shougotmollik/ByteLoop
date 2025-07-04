import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Colors.black,
    onSurface: Colors.white,
    surfaceTint: Colors.black12,
    primary: Colors.white,
    onPrimary: Colors.black12,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
    elevation: 0.0,
  ),

);
