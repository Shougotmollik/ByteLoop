import 'package:byteloop/model/BottomSheetItemModel.dart';
import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/nav_bar_service.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:byteloop/utils/type_def.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/query_card_bottom_bar.dart';
import 'package:byteloop/views/widgets/nav_bar/common_widget/video_player_widget.dart';
import 'package:byteloop/views/widgets/nav_bar/profile/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class QueryCard extends StatelessWidget {
  final QueryModel query;
  final bool isAuthCard;
  final DeleteCallback? callback;

  const QueryCard({
    super.key,
    required this.query,
    this.isAuthCard = false,
    this.callback,
  });

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
                    _buildQueryHeaderSection(query),
                    _buildTextQuerySection(),
                    const SizedBox(height: 12),
                    if (query.assets != null) _buildMediaPreview(context),

                    QueryCardBottomBar(query: query),
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
    return InkWell(
      onTap: () => Get.toNamed(RouteNames.showQueryScreen, arguments: query.id),
      child: Text(
        query.content!,
        style: const TextStyle(fontSize: 14, color: Colors.white70),
      ),
    );
  }

  Widget _buildQueryHeaderSection(QueryModel query) {
    final currentUserId = Supabase.instance.client.auth.currentUser!.id;
    final NavBarService navBarService = Get.find<NavBarService>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (query.userId == currentUserId) {
              navBarService.backToProfileScreen();
            } else {
              Get.toNamed(RouteNames.showUserProfile, arguments: query.userId);
            }
          },
          child: Text(
            query.user?.metadata?.name ?? "Unknown User",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(timeago.format(DateTime.parse(query.createdAt!))),
            const SizedBox(width: 6),
            InkWell(
              onTap: () {
                _buildHorizontalOptionButton(
                  query,
                  currentUserId,
                  navBarService,
                );
              },
              child: const Icon(Icons.more_horiz),
            ),
          ],
        ),
      ],
    );
  }

  // Horizontal Button to bottomSheet
  void _buildHorizontalOptionButton(
    QueryModel query,
    String currentUserId,
    NavBarService navBarService,
  ) {
    return showCustomBottomSheet(
      items: [
        BottomSheetItemModel(
          title: 'View Query',
          icon: Icons.question_mark_outlined,
          onTap: () {
            Get.toNamed(RouteNames.showQueryScreen, arguments: query.id);
          },
        ),
        BottomSheetItemModel(
          title: 'View Profile',
          icon: Iconsax.profile_circle,
          onTap: () {
            if (query.userId == currentUserId) {
              navBarService.backToProfileScreen();
            } else {
              Get.toNamed(RouteNames.showUserProfile, arguments: query.userId);
            }
          },
        ),
        if (isAuthCard)
          BottomSheetItemModel(
            title: 'Delete Query',
            onTap: () {
              showConfirmDialog(
                title: 'Are you sure',
                text: "once it's delete you won't able to recover it",
                onTap: () {
                  callback!(query.id!);
                },
              );
            },
            icon: Icons.delete_forever_outlined,
            iconColor: Colors.redAccent,
            titleColor: Colors.redAccent,
          )
        else
          BottomSheetItemModel(
            title: 'Report Query',
            onTap: () {},
            icon: Icons.report_outlined,
            iconColor: Colors.redAccent,
            titleColor: Colors.redAccent,
          ),
      ],
    );
  }

  Widget _buildMediaPreview(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouteNames.showAssets, arguments: query.assets),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.height * 0.60,
          maxWidth: context.width * 0.80,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: query.type == 'video'
              ? VideoPlayerWidget(url: getS3Url(query.assets!))
              : Image.network(
                  getS3Url(query.assets!),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
        ),
      ),
    );
  }
}
