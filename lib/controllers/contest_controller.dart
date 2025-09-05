import 'package:byteloop/model/contest_model.dart';
import 'package:get/get.dart';

import '../services/contest_service.dart';

class ContestController extends GetxController {
  var contests = <ContestModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final ContestService _service = ContestService();

  @override
  void onInit() {
    fetchContests();
    super.onInit();
  }

  void fetchContests() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await _service.fetchContests();
      contests.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
