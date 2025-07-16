import 'dart:io';

import 'package:byteloop/constant/app_assets.dart';
import 'package:byteloop/utils/helper.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double radius;
  final String? url;
  final File? file;

  const CustomCircleAvatar({super.key, this.radius = 20, this.url, this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (file != null)
          CircleAvatar(backgroundImage: FileImage(file!), radius: radius)
        else if (url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(getS3Url(url!)),
            radius: radius,
          )
        else
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage(AppAssets.profileAvatar),
          ),
      ],
    );
  }
}
