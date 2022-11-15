import 'package:flutter/material.dart';

class AppColor{
  // 컬러 표준화
  // 1. 기본 제공 컬러는 검은색, 흰색으로 총 2개 입니다.
  // 2. 디자이너가 제공해주는 사용 컬러 갯수 제한은 10개 이하 입니다.
  // 3. 개발자가 디테일하게 컬러를 더 뽑아 쓰고 싶으시다면 하단
  //    '개발자가 따로 뽑은 컬러' 밑에 따로 뽑아서 사용하세요.
  //    그러나 최대한 적게 뽑아쓰시는걸 권장 드립니다.

  ///********** 기본 제공 컬러 *************///
  static const Color black = Color.fromARGB(255, 0, 0, 0);       /// 기본 검은색
  static const Color white = Color.fromARGB(255, 250, 250, 250);    /// 기본 흰색

  ///********** 개발자가 따로 뽑은 컬러 *************///

  static const Color background = Color(0xffF4F5FB);                /// 백그라운드 컬러
  static const Color deepIndigo = Color(0xff14143B);                /// 남색
  static const Color blue = Color(0xff62ACE6);                      /// 파란색

  static const Color lightGrey = Color(0xffEFEFEF);                         /// 1
  static Color grey = Colors.grey.withOpacity(.60);                         /// 2
  static const Color deepGrey = Color(0xff707070);                          /// 3
  static const Color shadow = Color(0xffE8E9EE);                             /// 5

}