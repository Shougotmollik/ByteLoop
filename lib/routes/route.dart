import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/auth/login_screen.dart';
import 'package:byteloop/views/auth/register_screen.dart';
import 'package:byteloop/views/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static final getPages = [
    GetPage(name: RouteNames.splashScreen, page: () => SplashScreen()),
    GetPage(name: RouteNames.loginScreen, page: () => LoginScreen()),
    GetPage(name: RouteNames.registerScreen, page: () => RegisterScreen(),transition:Transition.leftToRight),
  ];
}
