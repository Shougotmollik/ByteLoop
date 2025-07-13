import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/controllers/auth_controller.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/utils/form_validator.dart';
import 'package:byteloop/views/widgets/auth/common_widgets/auth_text_form_field.dart';
import 'package:byteloop/views/widgets/auth/common_widgets/custom_auth_app_bar.dart';
import 'package:byteloop/views/widgets/auth/common_widgets/custom_rich_text.dart';
import 'package:byteloop/views/widgets/auth/common_widgets/custom_social_btn.dart';
import 'package:byteloop/views/widgets/auth/common_widgets/custom_submit_btn.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FormValidator _formValidator = FormValidator();

  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAuthAppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'Login Your Account',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    AuthTextFormField(
                      hintText: 'Enter Your Email',
                      prefixIcon: Icons.email_outlined,
                      textEditingController: _emailTEController,
                      validator: _formValidator.validateEmail,
                    ),
                    const SizedBox(height: 18),
                    AuthTextFormField(
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline_rounded,
                      textEditingController: _passwordTEController,
                      validator: _formValidator.validatePassword,
                      showToggle: true,
                    ),
                    const SizedBox(height: 04),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Obx(
                      () => CustomSubmitBtn(
                        onTap: _loginButton,
                        btnText: _authController.loginLoading.value
                            ? 'Loading..'
                            : 'Login',
                      ),
                    ),

                    const SizedBox(height: 12),
                    CustomRichText(
                      firstText: 'Create New Account?',
                      secondText: ' Register',
                      onTap: () {
                        Get.toNamed(RouteNames.registerScreen);
                      },
                    ),
                    const SizedBox(height: 18),
                    Divider(color: Colors.grey.shade600, thickness: 1),
                    const SizedBox(height: 18),
                    const Text(
                      'Continue With Accounts',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 18),

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
      ),
    );
  }

  void _loginButton() {
    _formValidator.validateAndProceed(_formKey, () {
      _authController.login(
        _emailTEController.text,
        _passwordTEController.text,
      );
    });
  }
}
