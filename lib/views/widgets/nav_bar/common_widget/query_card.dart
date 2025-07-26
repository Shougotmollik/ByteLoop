import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/video_player_widget.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class QueryCard extends StatelessWidget {
  final QueryModel query;

  const QueryCard({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: CustomCircleAvatar(url: query.user?.metadata?.image),
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

                    _buildLikeCommentShareToggleSection(),
                    _buildCommentLikeCountSection(),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xff242424)),
        ],
      ),
    );
  }

  Widget _buildTextQuerySection() {
    return Text(
      query.content!,
      style: const TextStyle(fontSize: 14, color: Colors.white70),
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

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Text(timeago.format(DateTime.parse(query.createdAt!))),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }

  Widget _buildLikeCommentShareToggleSection() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.heart_copy, weight: 24),
        ),
        IconButton(
          onPressed: () =>
              Get.toNamed(RouteNames.addReplayScreen, arguments: query),
          icon: const Icon(Iconsax.message_2_copy, weight: 24),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.send_2_copy, weight: 24),
        ),
      ],
    );
  }

  Widget _buildCommentLikeCountSection() {
    return Row(
      spacing: 8,
      children: [
        Text(
          "${query.commentCount} replies",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.greyColor,
          ),
        ),
        Text(
          "${query.likeCount} likes",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.greyColor,
          ),
        ),
      ],
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
