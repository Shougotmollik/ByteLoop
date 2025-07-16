import 'package:byteloop/controllers/auth_controller.dart';
import 'package:byteloop/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut(() => ProfileController());
  }
}
