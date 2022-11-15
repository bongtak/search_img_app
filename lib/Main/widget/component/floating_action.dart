import 'package:flutter/material.dart';
import 'package:search_img_app/Main/constants/colors.dart';

class FloatingCommunity extends StatelessWidget {
  const FloatingCommunity({Key? key, required this.onPressedMovingTop}) : super(key: key);
  final Function() onPressedMovingTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 5, bottom: 100),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColor.lightGrey,
          width: 1.0,
        ),
      ),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: AppColor.white,
        child: IconButton(
            splashColor: Colors.transparent, //버튼 클릭 이벤트 삭제
            highlightColor: Colors.transparent, //버튼 클릭 이벤트 삭제
            onPressed: onPressedMovingTop,
            iconSize: 20,
            icon: const Icon(Icons.arrow_upward_rounded, color: AppColor.black)
        ),
      ),
    );
  }
}