import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: const Color(0xff252526),
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    snackStyle: SnackStyle.GROUNDED,
    margin: EdgeInsets.all(0.0),
  );
}
