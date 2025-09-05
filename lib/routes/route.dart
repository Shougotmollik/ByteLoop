import 'package:byteloop/controller_binder.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/views/auth/login_screen.dart';
import 'package:byteloop/views/auth/register_screen.dart';
import 'package:byteloop/views/auth/splash_screen.dart';
import 'package:byteloop/views/auth/welcome_screen.dart';
import 'package:byteloop/views/main_navbar/contest/contest_details_screen.dart';
import 'package:byteloop/views/main_navbar/home/add_reply_screen.dart';
import 'package:byteloop/views/main_navbar/main_nav_bar_screen.dart';
import 'package:byteloop/views/main_navbar/notification/notification_screen.dart';
import 'package:byteloop/views/main_navbar/profile/edit_profile_screen.dart';
import 'package:byteloop/views/main_navbar/profile/profile_screen.dart';
import 'package:byteloop/views/main_navbar/profile/show_user_profile.dart';
import 'package:byteloop/views/main_navbar/query/show_asset.dart';
import 'package:byteloop/views/main_navbar/query/show_query_screen.dart';
import 'package:byteloop/views/main_navbar/search/search_screen.dart';
import 'package:byteloop/views/main_navbar/settings/settings_screen.dart';
import 'package:get/get.dart';

class Routes {
  static final getPages = [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.noTransition,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.registerScreen,
      page: () => const RegisterScreen(),
      transition: Transition.rightToLeft,
      binding: ControllerBinder(),
    ),

    GetPage(
      name: RouteNames.welcomeScreen,
      page: () => const WelcomeScreen(),
      transition: Transition.fade,
      binding: ControllerBinder(),
    ),

    GetPage(
      name: RouteNames.mainNavBarScreen,
      page: () => const MainNavBarScreen(),
      transition: Transition.fadeIn,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.searchScreen,
      page: () => const SearchScreen(),
      transition: Transition.rightToLeft,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.notificationScreen,
      page: () => const NotificationScreen(),
      transition: Transition.rightToLeft,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.profileScreen,
      page: () => const ProfileScreen(),
      transition: Transition.fadeIn,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.editProfileScreen,
      page: () => const EditProfileScreen(),
      transition: Transition.leftToRight,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.settingsScreens,
      page: () => const SettingsScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: ControllerBinder(),
    ),

    GetPage(
      name: RouteNames.addReplayScreen,
      page: () => const AddReplyScreen(),
      transition: Transition.downToUp,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.showQueryScreen,
      page: () => const ShowQueryScreen(),
      transition: Transition.fadeIn,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.showAssets,
      page: () => ShowAsset(),
      transition: Transition.fadeIn,
      binding: ControllerBinder(),
    ),
    GetPage(
      name: RouteNames.showUserProfile,
      page: () => const ShowUserProfile(),
      transition: Transition.leftToRightWithFade,
      binding: ControllerBinder(),
    ),
  ];
}
