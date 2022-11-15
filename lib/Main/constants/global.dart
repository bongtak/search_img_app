import 'package:get/get.dart';
import 'package:search_img_app/Main/modules/GetControllers/get_body.dart';
import 'package:search_img_app/Main/modules/api/api_http.dart';
import 'package:search_img_app/Main/modules/function/msg_show.dart';
import 'package:search_img_app/Main/modules/function/onbackpressed.dart';

var gb = Get.put(GetBody());
var global = Global(); // 글로벌 클래스 함수화
var onBackPressed = OnBackPressed(); // 뒤로 가기 시 앱 종료
var msgShow = MsgShow(); // 얼렛 메시지 호출
var apiHttp = ApiHttp(); // api 값 가져 오기

var listHeight = 100;
var listWith = 100;
var listCachedHeight = listHeight * 4;
var listCachedWith = listWith * 4;

class Global {

}
