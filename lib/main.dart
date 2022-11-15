import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:search_img_app/Main/pages/a_splash_page.dart';

/// 세모이 메인 셋팅
Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // 가로모드 방지

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false, //디버그 모드 해제
        title: '세모이',
        theme: ThemeData(
          primarySwatch: Colors.grey, // 프라이머리 컬러
          fontFamily: 'Noto Sans CJK KR', // 프라이머리 텍스트
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        popGesture: true,
        defaultTransition: Transition.cupertino,
        home: const SplashScreen(), //시작할 때 스플래쉬 페이지로 이동
      ),
    );

  }
}