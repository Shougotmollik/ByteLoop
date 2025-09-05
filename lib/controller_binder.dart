import 'package:byteloop/controllers/auth_controller.dart';
import 'package:byteloop/controllers/contest_controller.dart';
import 'package:byteloop/controllers/home_controller.dart';
import 'package:byteloop/controllers/notification_controller.dart';
import 'package:byteloop/controllers/profile_controller.dart';
import 'package:byteloop/controllers/query_controller.dart';
import 'package:byteloop/controllers/reply_controller.dart';
import 'package:byteloop/controllers/search_user_controller.dart';
import 'package:byteloop/controllers/settings_controller.dart';
import 'package:byteloop/services/nav_bar_service.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<ProfileController>(ProfileController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<QueryController>(() => QueryController());
    Get.lazyPut<ReplyController>(() => ReplyController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<SearchUserController>(() => SearchUserController());
    Get.lazyPut<ContestController>(() => ContestController());

    //   Service bindings
    Get.lazyPut<SupabaseService>(() => SupabaseService());
    Get.lazyPut<NavBarService>(() => NavBarService());
  }
}
