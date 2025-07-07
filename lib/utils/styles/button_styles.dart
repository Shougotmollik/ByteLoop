import 'package:flutter/material.dart';

ButtonStyle customOutlineStyle() {
  return ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
    ),
  );
}
