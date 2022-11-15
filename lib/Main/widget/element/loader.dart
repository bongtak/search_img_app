import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:search_img_app/Main/constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        SpinKitThreeBounce(
          // 화면 뺑글 뺑글
          color: AppColor.blue,
          size: 25.0,
        ),
      ],
    );
  }
}
