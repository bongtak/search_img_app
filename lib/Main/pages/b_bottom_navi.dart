import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/global.dart';
import 'package:search_img_app/Main/pages/e_my_page.dart';
import 'package:search_img_app/Main/pages/c_search_page.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({Key? key, required this.initialPage}) : super(key: key);

  final int initialPage;

  @override
  State<BottomNavi> createState() => _BottomNavi();
}

class _BottomNavi extends State<BottomNavi> {
  late int _currentIndex;


  final _kTabPages = <Widget>[
    const SearchPage(),
    const MyPage(),
  ];

  @override
  void initState() {
    _currentIndex = widget.initialPage; // 페이지 번호 초기화
    super.initState();
  }

  void onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_currentIndex == 0){
          bool result = onBackPressed.doubleOnBackPressed(context);
          return await Future.value(result);
        }else{
          setState(() {
            _currentIndex -= 1; // 네비바에서 한칸씩 뒤로 가기 위함
          });
          return false;
        }
      },
      child: Scaffold(
        extendBody: true, // 값을 하단 바튼 네비게이션 바에도 공통 적용 하기 위함
        bottomNavigationBar: SizedBox(
          height: GetPlatform.isAndroid ? 80 : 100,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColor.blue,
            unselectedItemColor: Colors.grey.withOpacity(.60),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontFamily: 'Noto Sans CJK KR',
                fontWeight: FontWeight.bold),
            currentIndex: _currentIndex,
            //현재 선택된 Index
            onTap: onTabTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: '이미지 검색',
                icon: Icon(Icons.devices_rounded),
              ),
              BottomNavigationBarItem(
                label: '마이페이지',
                icon: Icon(Icons.person_rounded),
              ),
            ],
          ),
        ),
        // indexedStack 페이지 전환 되지 않고 로드 상태로 기억하는 방법임
        body: IndexedStack(
          index: _currentIndex,
          children: _kTabPages,
        ),
      ),
    );
  }
}
