import 'package:flutter/material.dart';

class FormValidator {
  // Singleton pattern (optional)
  static final FormValidator _instance = FormValidator._internal();
  factory FormValidator() => _instance;
  FormValidator._internal();

  // After validation function
  bool validateAndProceed(GlobalKey<FormState> formKey, Function() onSuccess) {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      onSuccess();
      return true;
    }
    return false;
  }

  // Email Validation Function
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation function
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  //   Name validator function
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Name should contain only letters';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.length > 50) {
      return 'Name is too long';
    }

    return null;
  }
}
