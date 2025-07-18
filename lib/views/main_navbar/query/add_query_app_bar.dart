import 'package:flutter/material.dart';

class AddQueryAppBar extends StatelessWidget {
  const AddQueryAppBar({super.key, required this.tapCloseQuery});

  final VoidCallback tapCloseQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: tapCloseQuery,
              icon: const Icon(Icons.close, color: Colors.white, size: 26),
            ),
            const Text(
              'New Query',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
