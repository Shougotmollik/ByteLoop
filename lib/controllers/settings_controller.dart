import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/storage_service.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/storage_keys.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // * logout method
  void logOut() async {
    //* remove user session from local storage
    StorageService.session.remove(StorageKeys.userSession);
    await SupabaseService.client.auth.signOut();
    Get.offAllNamed(RouteNames.loginScreen);
  }
}
