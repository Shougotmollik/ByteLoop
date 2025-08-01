import 'package:byteloop/constant/app_colors.dart';
import 'package:byteloop/controllers/query_controller.dart';
import 'package:byteloop/model/query_model.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class QueryCardBottomBar extends StatefulWidget {
  const QueryCardBottomBar({super.key, required this.query});

  final QueryModel query;

  @override
  State<QueryCardBottomBar> createState() => _QueryCardBottomBarState();
}

class _QueryCardBottomBarState extends State<QueryCardBottomBar> {
  String likeStatus = "";
  final QueryController controller = Get.find<QueryController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  //** Like dislike function
  void likeDislike(String status) async {
    setState(() {
      likeStatus = status;
    });
    if (likeStatus == "0") {
      widget.query.likes = [];
    }
    await controller.likeDislike(
      status,
      widget.query.id!,
      widget.query.userId!,
      supabaseService.currentUser.value!.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            likeStatus == '1' || widget.query.likes!.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      likeDislike("0");
                    },
                    icon: const Icon(
                      Iconsax.heart,
                      color: Colors.red,
                      weight: 24,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      likeDislike("1");
                    },
                    icon: const Icon(Iconsax.heart_copy, weight: 24),
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
        Row(
          spacing: 8,
          children: [
            Text(
              "${widget.query.commentCount} replies",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor,
              ),
            ),
            Text(
              "${widget.query.likeCount} likes",
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
