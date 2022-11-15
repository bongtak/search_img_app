import 'package:flutter/material.dart';

class AppTextStyle{
  ///************************************ 표준화 *************************************///
  // 텍스트 표준화
  // 1. 표준화된 텍스트의 갯수는 총 20개 입니다
  // 2. 노말체 (12, 14, 16, 18, 20, 24, 28, 30, 34, 38) 총 10개 (n)
  // 3. 볼드체 (12, 14, 16, 18, 20, 24, 28, 30, 34, 38) 총 10개 (b)
  // 4. Text   1,  2,  3,  4,  5,  6,  7,  8,  9,  10  기준 입니다.

  /// 1 - 텍스트 사이즈 12 + 볼드
  static TextStyle nText12(Color color){
    return TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText12(Color color){
    return TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.bold,
    );
  }

  /// 2 - 텍스트 사이즈 14 + 볼드
  static TextStyle nText14(Color color){
    return TextStyle(
      fontSize: 14,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText14(Color color){
    return TextStyle(
      fontSize: 14,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 3 - 텍스트 사이즈 16 + 볼드
  static TextStyle nText16(Color color){
    return TextStyle(
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText16(Color color){
    return TextStyle(
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 4 - 텍스트 사이즈 18 + 볼드
  static TextStyle nText18(Color color){
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText18(Color color){
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 5 - 텍스트 사이즈 20 + 볼드
  static TextStyle nText20(Color color){
    return TextStyle(
      fontSize: 20,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText20(Color color){
    return TextStyle(
      fontSize: 20,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 6 - 텍스트 사이즈 24 + 볼드
  static TextStyle nText24(Color color){
    return TextStyle(
      fontSize: 24,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText24(Color color){
    return TextStyle(
      fontSize: 24,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 7 - 텍스트 사이즈 28 + 볼드
  static TextStyle nText28(Color color){
    return TextStyle(
      fontSize: 28,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText28(Color color){
    return TextStyle(
      fontSize: 28,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 8 - 텍스트 사이즈 30 + 볼드
  static TextStyle nText30(Color color){
    return TextStyle(
      fontSize: 30,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText30(Color color){
    return TextStyle(
      fontSize: 30,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 9 - 텍스트 사이즈 34 + 볼드
  static TextStyle nText34(Color color){
    return TextStyle(
      fontSize: 34,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText34(Color color){
    return TextStyle(
      fontSize: 34,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  /// 10 - 텍스트 사이즈 38 + 볼드
  static TextStyle nText38(Color color){
    return TextStyle(
      fontSize: 38,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
  static TextStyle bText38(Color color){
    return TextStyle(
      fontSize: 38,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  ///************************************ 추가개발 *************************************///

}