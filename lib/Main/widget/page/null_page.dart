import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/textstyle.dart';

class NullPage extends StatelessWidget {
  const NullPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: Get.height * 0.05),
            child: Icon(Icons.search_rounded, size: Get.width * 0.6,color: AppColor.grey)
        ),
        Text("검색어를 입력해주세요.", style: AppTextStyle.bText14(AppColor.deepGrey),)
      ],
    );
  }
}
