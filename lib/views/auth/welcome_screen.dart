import 'package:byteloop/constant/app_assets.dart';
import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/widgets/auth/common_widgets/custom_social_btn.dart';
import 'package:byteloop/views/widgets/auth/common_widgets/custom_submit_btn.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.imageLogo),
                  const SizedBox(height: 68),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      ' Welcome to ByteLoop',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 58),
                  CustomSubmitBtn(
                    onTap: () {
                      Get.toNamed(RouteNames.loginScreen);
                    },
                    btnText: 'Login',
                  ),
                  const SizedBox(height: 22),
                  CustomSubmitBtn(
                    onTap: () {
                      Get.toNamed(RouteNames.registerScreen);
                    },
                    btnText: 'Register',
                  ),
                  const SizedBox(height: 58),
                  const Text(
                    'Continue With Accounts',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),

                  const SizedBox(height: 38),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 18,
                    children: [
                      Expanded(
                        child: CustomSocialBtn(
                          btnText: 'GOOGLE',
                          btnColor: AppColors.googleBtnColor.withAlpha(60),
                          textColor: AppColors.googleBtnColor,
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: CustomSocialBtn(
                          btnText: 'FACEBOOK',
                          btnColor: AppColors.facebookBtnColor.withAlpha(60),
                          textColor: AppColors.facebookBtnColor,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
