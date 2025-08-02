import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  RxList<QueryModel> queries = RxList<QueryModel>();

  @override
  void onInit() async {
    await fetchQuery();
    await listenQueryChange();
    super.onInit();
  }

  // Fetch query
  Future<void> fetchQuery() async {
    loading.value = true;

    final List<dynamic> response = await SupabaseService.client
        .from('posts')
        .select('''
      id,content,assets,type,created_at,comment_count,like_count,user_id,
      user:user_id(email,metadata),likes:likes(user_id,post_id)
      ''')
        .order("id", ascending: false);

    loading.value = false;
    if (response.isNotEmpty) {
      queries.value = [for (var item in response) QueryModel.fromJson(item)];
    }
  }

  //   ** listen realtime query changes
  Future<void> listenQueryChange() async {
    final supabase = SupabaseService.client;
    supabase
        .channel('public:posts')
        // INSERT listener
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'posts',
          callback: (payload) async {
            final newId = payload.newRecord['id'];

            // Fetch the full post with user info
            final response = await supabase
                .from('posts')
                .select(
                  'id,content,assets,type,created_at,comment_count,like_count,user_id,user:user_id(email,metadata)',
                )
                .eq('id', newId)
                .single();

            final fullPost = QueryModel.fromJson(response);
            queries.insert(0, fullPost); // Add new post at the top
            update(); // Notify UI
          },
        )
        // DELETE listener
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'posts',
          callback: (payload) {
            final deletedId = payload.oldRecord['id'];
            queries.removeWhere((post) => post.id == deletedId);
            update(); // Notify UI
          },
        )
        .subscribe();
  }
}
