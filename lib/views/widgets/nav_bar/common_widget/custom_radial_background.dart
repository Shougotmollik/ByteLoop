import 'package:byteloop/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRadialBackground extends StatelessWidget {
  const CustomRadialBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 0.75,
          colors: [
            Color(0xff14041f),
            Color.fromARGB(160, 60, 0, 90),
            AppColors.bgColor,
          ],
          stops: [0.0, 0.3, 1.0],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
