import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_img_app/Main/constants/colors.dart';

class MsgShow{
  void msgShow(String title, String subtitle) {
    Get.snackbar(
      "",
      "",
      titleText: Text(
        title,
        style: const TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        subtitle,
        style: const TextStyle(color: AppColor.black),
      ),
      backgroundColor: AppColor.white,
      borderColor: AppColor.black,
      borderWidth: 0.5,
    );
  }
}