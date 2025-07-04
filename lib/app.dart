import 'package:byteloop/routes/route.dart';
import 'package:byteloop/routes/route_names.dart';
import 'package:byteloop/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ByteLoopApp extends StatelessWidget {
  const ByteLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ByteLoop',
      theme: darkTheme,
      getPages: Routes.getPages,
      initialRoute: RouteNames.splashScreen,
    );
  }
}
