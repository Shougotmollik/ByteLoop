import 'package:flutter/material.dart';

class CustomSubmitBtn extends StatelessWidget {
  const CustomSubmitBtn({
    super.key,
    required this.onTap,
    required this.btnText,
  });
  final VoidCallback onTap;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff141718),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            btnText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
