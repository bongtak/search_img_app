import 'package:flutter/material.dart';

class AppBorder{
  ///************************************ 표준화 *************************************///
  // 보더(테두리) 표준화
  // 1. 보더의 사이즈는 총 5개가 제공됩니다.
  // 2. 매우얇음, 얇음, 중간, 굵음, 매우굵음의 종류가 있습니다.
  // 3. border1,  2,   3,   4,   5,  기준 입니다.

  /// 매우 얇음 테두리
  static BorderSide border1(Color color){
    return BorderSide(
      color: color,
      width: 0.3,
      style: BorderStyle.solid,
    );
  }

  /// 얇음 테두리
  static BorderSide border2(Color color){
    return BorderSide(
      color: color,
      width: 1,
      style: BorderStyle.solid,
    );
  }

  /// 중간 테두리
  static BorderSide border3(Color color){
    return BorderSide(
      color: color,
      width: 5,
      style: BorderStyle.solid,
    );
  }

  /// 굵음 테두리
  static BorderSide border4(Color color){
    return BorderSide(
      color: color,
      width: 10,
      style: BorderStyle.solid,
    );
  }

  /// 매우 굵음 테두리
  static BorderSide border5(Color color){
    return BorderSide(
      color: color,
      width: 20,
      style: BorderStyle.solid,
    );
  }

  ///************************************ 추가개발 *************************************///

}