import 'package:byteloop/controllers/reply_controller.dart';
import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_circular_progress_indicator.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/custom_radial_background.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/reply_card.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/video_player_widget.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReplyScreen extends StatefulWidget {
  const AddReplyScreen({super.key});

  @override
  State<AddReplyScreen> createState() => _AddReplyScreenState();
}

class _AddReplyScreenState extends State<AddReplyScreen> {
  late final QueryModel query;
  late final ReplyController replyController;
  late final SupabaseService supabaseService;

  @override
  void initState() {
    super.initState();
    replyController = Get.find<ReplyController>();
    query = Get.arguments;
    supabaseService = Get.find<SupabaseService>();
    replyController.fetchReplies(query.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarSection(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      body: CustomRadialBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.width * 0.12,
                      child: CustomCircleAvatar(
                        url: query.user?.metadata?.image,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: context.width * 0.80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildQueryHeaderSection(),
                          _buildTextQuerySection(),
                          const SizedBox(height: 12),
                          if (query.assets != null) _buildMediaPreview(context),
                          const SizedBox(height: 12),

                          _buildReplyTextFromFieldSection(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ReplyCard(postId: query.id!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReplyTextFromFieldSection() {
    return TextFormField(
      autofocus: true,
      controller: replyController.replyTEController,
      onChanged: (value) => replyController.reply.value = value,
      maxLines: 8,
      minLines: 1,
      maxLength: 500,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      decoration: const InputDecoration(
        hintText: 'Type a reply',
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white38,
        ),
        border: InputBorder.none,
      ),
    );
  }

  AppBar _buildAppBarSection() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.close),
      ),
      title: const Text('Reply'),
      actions: [
        Obx(
          () => TextButton(
            onPressed: () {
              if (replyController.reply.isNotEmpty) {
                replyController.addReply(
                  supabaseService.currentUser.value!.id,
                  query.id!,
                  query.userId!,
                );
              }
            },
            child: replyController.loading.value
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CustomCircularProgressIndicator(),
                  )
                : Text(
                    'Reply',
                    style: TextStyle(
                      color: replyController.reply.isNotEmpty
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildQueryHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          query.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildTextQuerySection() {
    return Text(
      query.content!,
      style: const TextStyle(fontSize: 14, color: Colors.white70),
    );
  }

  Widget _buildMediaPreview(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: context.height * 0.60,
        maxWidth: context.width * 0.80,
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8.0),
        child: query.type == 'video'
            ? VideoPlayerWidget(url: getS3Url(query.assets!))
            : Image.network(
                getS3Url(query.assets!),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
      ),
    );
  }
}
