import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:search_img_app/Main/constants/borders.dart';
import 'package:search_img_app/Main/constants/colors.dart';


class InCardProfileImg extends StatelessWidget {
  const InCardProfileImg({Key? key, required this.imgPath}) : super(key: key);
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.asset(
      imgPath,
      height: 80,
      width: 80,
      shape: BoxShape.circle,
      fit: BoxFit.cover,
    );
  }
}
