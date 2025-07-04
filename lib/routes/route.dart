import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/auth/login_screen.dart';
import 'package:byteloop/views/auth/register_screen.dart';
import 'package:byteloop/views/auth/splash_screen.dart';
import 'package:byteloop/views/auth/welcome_screen.dart';
import 'package:get/get.dart';

class Routes {
  static final getPages = [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.loginScreen,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.registerScreen,
      page: () => RegisterScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteNames.welcomeScreen,
      page: () => WelcomeScreen(),
      transition: Transition.fade,
    ),
  ];
}
