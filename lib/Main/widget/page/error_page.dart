import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/textstyle.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: Get.height * 0.05),
            child: Icon(Icons.wifi_rounded, size: Get.width * 0.6,color: AppColor.grey)
        ),
        Text("인터넷 연결상태를 확인해주세요.", style: AppTextStyle.bText14(AppColor.deepGrey),)
      ],
    );
  }
}
