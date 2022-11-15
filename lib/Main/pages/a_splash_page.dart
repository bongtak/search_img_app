import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/textstyle.dart';
import 'package:search_img_app/Main/pages/b_bottom_navi.dart';

/// 스플래시 스크린
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ///************************************ 변수 *************************************///


  ///************************************ 함수 *************************************///

  ///스플래쉬 이미지 몇초간 유지 할것인지
  Future<Timer> startTime() async {
    var _duration = const Duration(seconds: 2); // 몇초간 스플래쉬 이미지 보여줄것인지
    return Timer(_duration, _goToMain);
  }

  ///스플래시 끝나고 이동할 페이지
  void _goToMain(){
    Get.to(()=> const BottomNavi(initialPage: 0));
  }

  ///페이지 진입 시 처음 실행되는 함수
  @override
  void initState() {
    startTime();
    super.initState();
  }

  ///************************************ 빌드 *************************************///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          ///백그라운드 그라데이션
          decoration:  const BoxDecoration( // 박스 데코레이션 함수
              gradient: LinearGradient( // 그라데이션 함수
                colors: [
                  AppColor.deepIndigo, // 회색빛 어두운 블루
                  AppColor.blue, // 푸른빛 밝은 회색
                  //AppColor.deepGreen, // 회색빛 어두운 블루
                ],
                stops: [0.0, 1.0], // 쉐도우 조절
                begin: FractionalOffset.center, // 중앙에서 시작해서
                end: FractionalOffset.bottomCenter, // 하단중앙 까지
              )
          ),
          ///이미지, 텍스트 등
          child: Stack(
            children: [
              ///하단의 지구 이미지
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: Image.asset("img/earth.png"),
                ),
              ),
              ///상단의 세모이 텍스트
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _richText(first: '세', second: '상의'),
                      _richText(first: '모', second: '든'),
                      _richText(first: '이', second: '미지를 담았다.'),
                    ],
                  ),
                )
              ),
            ],
          ),
        )
    );
  }

  ///************************************ 위젯 *************************************///

  ///Row 텍스트
  Widget _richText({
    required String first,
    required String second,
  }){
    return Text.rich(
      TextSpan(
        text: first,
        style: AppTextStyle.bText38(AppColor.blue),
        children: <TextSpan>[
          TextSpan(
            text: second,
            style: AppTextStyle.bText38(AppColor.white),
          ),
          // can add more TextSpans here...
        ],
      ),
    );
  }

}
