import 'dart:io';

import 'package:byteloop/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QueryController extends GetxController {
  final TextEditingController queryTEController = TextEditingController();
  var content = ''.obs;
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  @override
  void dispose() {
    queryTEController.dispose();
    super.dispose();
  }


  void pickImage()async{
    File?file=await pickImageFromGallery();
    if(file!=null){
      image.value=file;
    }
  }
}
