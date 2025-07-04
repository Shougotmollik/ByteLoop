import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/widgets/common_widgets/auth_text_form_field.dart';
import 'package:byteloop/views/widgets/common_widgets/custom_rich_text.dart';
import 'package:byteloop/views/widgets/common_widgets/custom_submit_btn.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
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
                  ),
                  const SizedBox(height: 18),
                  AuthTextFormField(
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline_rounded,
                    textEditingController: _passwordTEController,
                    showToggle: true,
                  ),
                  const SizedBox(height: 04),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  CustomSubmitBtn(onTap: () {}, btnText: 'Login'),
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
                  Text(
                    'Continue With Accounts',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),

                  const SizedBox(height: 18),
                  Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(),
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
