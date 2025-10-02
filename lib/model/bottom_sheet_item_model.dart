import 'package:flutter/material.dart';

class BottomSheetItemModel {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconColor;

  BottomSheetItemModel({
    required this.title,
    required this.onTap,
    this.icon,
    this.titleColor,
    this.iconColor,
  });
}
