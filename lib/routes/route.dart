import 'package:byteloop/controller_binder.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/auth/login_screen.dart';
import 'package:byteloop/views/auth/register_screen.dart';
import 'package:byteloop/views/auth/splash_screen.dart';
import 'package:byteloop/views/auth/welcome_screen.dart';
import 'package:byteloop/views/main_navbar/home/add_reply_screen.dart';
import 'package:byteloop/views/main_navbar/main_nav_bar_screen.dart';
import 'package:byteloop/views/main_navbar/profile/edit_profile_screen.dart';
import 'package:byteloop/views/main_navbar/settings/settings_screen.dart';
import 'package:get/get.dart';

class Routes {
  static final getPages = [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.registerScreen,
      page: () => const RegisterScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteNames.welcomeScreen,
      page: () => const WelcomeScreen(),
      transition: Transition.fade,
    ),

    GetPage(
      name: RouteNames.mainNavBarScreen,
      page: () => const MainNavBarScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.editProfileScreen,
      page: () => const EditProfileScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.settingsScreens,
      page: () => const SettingsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),

    GetPage(
      name: RouteNames.addReplayScreen,
      page: () => const AddReplyScreen(),
      transition: Transition.downToUp,
      binding: ControllerBinder(),
    ),
  ];
}
