import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 뒤로 가기시 앱 종료
class OnBackPressed {
  DateTime? currentBackPressTime;

  /// 뒤로 가기 연속 2회시 하단 얼렛 띄우고 앱 종료
  bool doubleOnBackPressed(context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff6E6E6E),
          fontSize: 17,
          toastLength: Toast.LENGTH_SHORT);
      return false;
    }
    return true;
  }

  /// 뒤로가기시 얼렛 메시지 띄우고 앱 종료
  Future<dynamic> alertOnBackPressed(context) {
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text(
              "앱 종료 하시겠습니까?",
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "종료하기",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'), // 앱종료 함수
              ),
              TextButton(
                child: const Text(
                  "취소",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
    );
  }
}