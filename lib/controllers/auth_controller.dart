import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/storage_service.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:byteloop/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  var registerLoading = false.obs;
  var loginLoading = false.obs;

  //   account registration
  Future<void> register(String name, String email, String password) async {
    try {
      registerLoading.value = true;
      final AuthResponse data = await SupabaseService.client.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      );
      registerLoading.value = false;
      if (data.user != null) {
        StorageService.session.write(
          StorageKeys.userSession,
          data.session?.toJson(),
        );
        Get.offAllNamed(RouteNames.mainNavBarScreen);
      }
    } on AuthException catch (error) {
      registerLoading.value = false;
      showSnackBar('Error', error.message);
    }
  }

  //   Login to account
  Future<void> login(String email, String password) async {
    try {
      loginLoading.value = true;
      final AuthResponse response = await SupabaseService.client.auth
          .signInWithPassword(email: email, password: password);
      loginLoading.value = false;
      if (response.user != null) {
        StorageService.session.write(
          StorageKeys.userSession,
          response.session?.toJson(),
        );
        Get.offAllNamed(RouteNames.mainNavBarScreen);
      }
    } on AuthException catch (error) {
      loginLoading.value = false;
      showSnackBar('Error', error.message);
    }
  }
}
