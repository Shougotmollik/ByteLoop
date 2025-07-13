import 'package:byteloop/constant/app_assets.dart';
import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/constant/app_string.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Get.offNamed(
          StorageService.userSession != null
              ? RouteNames.mainNavBarScreen
              : RouteNames.welcomeScreen,
        );
      }
    });
  }

  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(AppAssets.logo, width: 138),
            const Spacer(),
            const Text(
              AppString.appName,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 34,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              AppString.appVersion,
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
