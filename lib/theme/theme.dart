import 'package:byteloop/constant/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    surface: AppColors.bgColor,
    onSurface: Colors.white,
    surfaceTint: Colors.black12,
    primary: Colors.white,
    onPrimary: Colors.black12,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: AppColors.bgColor,
    elevation: 0.0,
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    height: 75,
    indicatorColor: Colors.transparent,
    backgroundColor: AppColors.bgColor,
    iconTheme: WidgetStateProperty.all<IconThemeData>(
      const IconThemeData(color: Colors.white, size: 28),
    ),
  ),
);
