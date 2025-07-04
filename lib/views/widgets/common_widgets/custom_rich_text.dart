import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });
  final String firstText;
  final String secondText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: firstText,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: secondText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
