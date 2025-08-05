import 'package:byteloop/constant/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieSearchWidget extends StatelessWidget {
  const LottieSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "search users by their username",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Lottie.asset(AppAssets.lottieSearch),
        ],
      ),
    );
  }
}