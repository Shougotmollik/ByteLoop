import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/controllers/query_controller.dart';
import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class QueryCardBottomBar extends StatefulWidget {
  final QueryModel query;

  const QueryCardBottomBar({super.key, required this.query});

  @override
  State<QueryCardBottomBar> createState() => _QueryCardBottomBarState();
}

class _QueryCardBottomBarState extends State<QueryCardBottomBar> {
  late bool isLiked;
  late int likeCount;
  final QueryController controller = Get.find<QueryController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    super.initState();
    final currentUserId = supabaseService.currentUser.value?.id;
    // Check if current user liked this post already
    isLiked =
        widget.query.likes?.any((like) => like.userId == currentUserId) ??
        false;
    likeCount = widget.query.likeCount ?? 0;
  }

  void toggleLike() async {
    final currentUserId = supabaseService.currentUser.value?.id;
    if (widget.query.id == null || currentUserId == null) return;

    // Optimistic UI update
    setState(() {
      if (isLiked) {
        isLiked = false;
        likeCount = (likeCount > 0) ? likeCount - 1 : 0;
      } else {
        isLiked = true;
        likeCount = likeCount + 1;
      }
    });

    try {
      await controller.likeDislike(
        isLiked ? "1" : "0",
        widget.query.id!,
        widget.query.userId!,
        currentUserId,
      );
    } catch (e) {
      // On error, revert UI changes
      setState(() {
        if (isLiked) {
          isLiked = false;
          likeCount = (likeCount > 0) ? likeCount - 1 : 0;
        } else {
          isLiked = true;
          likeCount = likeCount + 1;
        }
      });
      Get.snackbar("Error", "Failed to update like. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: toggleLike,
              icon: Icon(
                isLiked ? Iconsax.heart : Iconsax.heart_copy,
                color: isLiked ? Colors.red : null,
                weight: 24,
              ),
            ),
            IconButton(
              onPressed: () => Get.toNamed(
                RouteNames.addReplayScreen,
                arguments: widget.query,
              ),
              icon: const Icon(Iconsax.message_2_copy, weight: 24),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.send_2_copy, weight: 24),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              "$likeCount likes",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "${widget.query.commentCount ?? 0} replies",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
