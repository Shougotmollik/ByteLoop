import 'package:flutter/material.dart';

class AddQueryAppBar extends StatelessWidget {
  const AddQueryAppBar({
    super.key,
    required this.tapCloseQuery,
    required this.tapPost,
  });

  final VoidCallback tapCloseQuery;
  final VoidCallback tapPost;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton.icon(
              onPressed: tapCloseQuery,
              icon: const Icon(Icons.close, color: Colors.white, size: 26),
              label: const Text(
                'New Query',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: tapPost,
              icon: const Icon(Icons.send_outlined, size: 22),
            ),
          ],
        ),
        const Divider(color: Colors.white24, thickness: 0.2),
      ],
    );
  }
}
