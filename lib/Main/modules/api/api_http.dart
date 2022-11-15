import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:search_img_app/Main/constants/global.dart';


class ApiHttp {

  /// 다음 이미지 검색 API
  Future<List> getSearchImg({
  required String query,
  required int page,
}) async {
    print('다음 이미지 검색 API 시작');
    String returnValue = ''; // 리턴 결과 받을 변수
    List data = [];

    await http
        .get(Uri.parse("https://dapi.kakao.com/v2/search/image?query=$query&page=$page&size=30"), headers: {"Authorization": "KakaoAK bcebd7566d2cdde4736cb835cbe428b4"})
        .then((response) => print('Get 응답 내용 : ${returnValue = utf8.decode(response.bodyBytes)}')) //utf8을 감싸는 이유는 한글 깨지는 것을 방지하기 위함이다.
        .catchError((error) {
          msgShow.msgShow("[안내사항]", "인터넷 연결 상태가 좋지 않습니다. 확인 후 다시 시도해주세요.");
          print('에러 내용 : $error');
        })
        .timeout(const Duration(seconds: 5),
        onTimeout: () {
          msgShow.msgShow("[안내사항]", "인터넷 연결 상태가 좋지 않습니다. 확인 후 다시 시도해주세요.");
      },
    );
    var value = json.decode(returnValue);
    List finalValue = value["documents"];
    data.addAll(finalValue);

    print('다음 이미지 검색 API 종료');
    return data; //api 체크 후 리턴
  }

}