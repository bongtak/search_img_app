import 'package:flutter/material.dart';

class AppShadow{
  ///************************************ 표준화 *************************************///
  // 쉐도우 표준화
  // 1. 쉐도우 종류는 총 5개가 제공됩니다.
  // 2. 쉐도우의 종류는 위왼쪽, 위오른쪽, 중앙전체, 밑왼쪽, 밑오른쪽 이 있습니다.
  // 3. shadow       TL,     TR,     A,    BL,    BR   이 기준 입니다.

  /// 위 왼쪽 쉐도우
  static BoxShadow shadowTL(Color color){
    return BoxShadow(
        color: color, // 컬러
        offset: const Offset(-3, -3), // X축 Y축
        blurRadius: 6 // 블러 강도
    );
  }

  /// 위 오른쪽 쉐도우
  static BoxShadow shadowTR(Color color){
    return BoxShadow(
        color: color, // 컬러
        offset: const Offset(3, -3), // X축 Y축
        blurRadius: 6 // 블러 강도
    );
  }

  /// 중앙 전체 쉐도우
  static BoxShadow shadowA(Color color){
    return BoxShadow(
        color: color, // 컬러
        offset: const Offset(0, 0), // X축 Y축
        blurRadius: 6 // 블러 강도
    );
  }

  /// 밑 왼쪽 쉐도우
  static BoxShadow shadowBR(Color color){
    return BoxShadow(
        color: color, // 컬러
        offset: const Offset(3, 3), // X축 Y축
        blurRadius: 4 // 블러 강도
    );
  }

  /// 밑 왼쪽 쉐도우
  static BoxShadow shadowBL(Color color){
    return BoxShadow(
        color: color, // 컬러
        offset: const Offset(-3, 3), // X축 Y축
        blurRadius: 6 // 블러 강도
    );
  }

  /// 밑 왼쪽 쉐도우
  static BoxShadow bannerShadowBR(Color color){
    return BoxShadow(
        color: color, // 컬러
        offset: const Offset(3, 3), // X축 Y축
        blurRadius: 6 // 블러 강도
    );
  }

}