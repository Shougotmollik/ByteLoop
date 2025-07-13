import 'package:flutter/material.dart';

class CustomSocialBtn extends StatelessWidget {
  const CustomSocialBtn({
    super.key,
    required this.btnText,
    required this.btnColor,
    required this.textColor,
    required this.onTap,
  });

  final String btnText;
  final Color btnColor;
  final Color textColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 175,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
