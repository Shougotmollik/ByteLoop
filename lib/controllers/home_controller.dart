import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  RxList<QueryModel> queries = RxList<QueryModel>();

  @override
  void onInit() async {
    await fetchQuery();
    super.onInit();
  }

  Future<void> fetchQuery() async {
    loading.value = true;

    final List<dynamic> response = await SupabaseService.client
        .from('posts')
        .select('''
      id,content,assets,type,created_at,comment_count,like_count,user_id,
      user:user_id(email,metadata)
      ''')
        .order("id", ascending: false);
    loading.value = false;
    if (response.isNotEmpty) {
      queries.value = [for (var item in response) QueryModel.fromJson(item)];
    }
  }
}
