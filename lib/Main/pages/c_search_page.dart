import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/global.dart';
import 'package:search_img_app/Main/constants/textstyle.dart';
import 'package:search_img_app/Main/pages/d_img_page.dart';
import 'package:search_img_app/Main/widget/component/floating_action.dart';
import 'package:search_img_app/Main/widget/component/filter_choice_chip.dart';
import 'package:search_img_app/Main/widget/element/loader.dart';
import 'package:search_img_app/Main/widget/component/text_field_box.dart';
import 'package:search_img_app/Main/widget/page/empty_page.dart';
import 'package:search_img_app/Main/widget/page/error_page.dart';
import 'package:search_img_app/Main/widget/page/null_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> with SingleTickerProviderStateMixin<SearchPage> {
  ///************************************ 변수 *************************************///

  final StreamController _streamController = StreamController<List>(); //스트림 빌더 컨트롤러
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //검색창 폼 키
  final TextEditingController _searchQuery = TextEditingController(); //검색창 키
  ScrollController _scrollController = ScrollController(); //플로팅 스크롤 버튼 컨트롤러

  List<String> _keyword = []; //자동검색어 필터
  List<String> _showKeyword = []; //자동검색어 리버스
  final List<String> _filterIds = []; //최종 선택 필터
  final List _data = []; //데이터
  List _sqlResult = []; //로그 쿼리
  final int _limit = 30; //리밋 개수
  int _cntSql = 1; //결과 페이지 번호, 1~50 사이의 값, 기본 값 1
  double appbar = 24; //벨리데이션 영역 추가 값
  late String _tem; //무한 스크롤 할때 값을 상실 하지 않기 위함
  bool _checkFilter = true; //최초에 값을 초기화 하고 이후에 닫아 버림
  bool? _isLoading = true; //로딩 필요 여부
  Timer? _debounce; //타이머

  ///************************************ 함수 *************************************///

  ///API 에서 데이터 불러오기 함수
  Future<void> _getData(String val) async {
    _sqlResult = await apiHttp.getSearchImg(query: val, page: _cntSql);

    // 필터를 터치 했다면 기존값 초기화 후 재실행
    if (_checkFilter) {
      _data.clear(); // 기존 데이터 클리어
      _checkFilter = false;
      _streamController.sink.add(_data);
    }

    // 받아온 데이터가 값이 존재할 시
    if (_sqlResult.isNotEmpty) {
      _cntSql = _cntSql + 1; // 결과 페이지 번호 증가
      setState(() {
        _isLoading = false;
        _data.addAll(_sqlResult); // 값 갱신
        _streamController.sink.add(_data);
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  ///최근검색어 가져오기 함수
  Future<void> _getKeyWord() async {
    final _prefs = await SharedPreferences.getInstance(); // 자동검색어 구현을 위해서 로컬에 떨굼
    try {
      setState(() {
        _keyword = _prefs.getStringList('search')!; // 로컬에 있는 필터값 가져 오기
        _showKeyword = List.from(_keyword.reversed); // 최근검색을 보여주기위해서 역순으로 정렬(리버스)
      });
    } catch(e) {
      print(e);
    }
  }

  ///필터를 눌렸을시 실행 함수
  Future<void> _initData(label) async{
    setState(() {
      _searchQuery.clear();//텍스트에 무엇을 적었던 날리기
      _filterIds.clear(); //필터비우기
      _filterIds.add(label);
      _checkFilter = true; // 스트림 값을 초기화 시키고
      _cntSql = 1; // 초기화 해서 다시 값을 불러 오고
      _tem = label; // 30개 이상 무한 스크롤 할때 변수값 상실을 반지 하기 위함
    });
    await _getData(label); //데이터 불러 오기
  }

  ///검색 하였을때 실행 함수
  void _onSearchChanged() {
    // (.isActive : 현재 타이머 활성화 여부)
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    // 1초가 지나고 검색 실행
    _debounce = Timer(const Duration(milliseconds: 1000), () async {

      /// 검색을 하였을 시 새 검색어의 데이터를 정상적으로 받아오기 위한 과정
      final prefs = await SharedPreferences.getInstance(); // 자동검색어 구현을 위해서 로컬에 떨굼
      _tem = _searchQuery.text; // 30개 단위 무한 스크롤 할때 값을 상실하지 않기
      _filterIds.clear(); // 선택된 필터 초기화
      _data.clear();      // 기존 데이터 초기화
      _cntSql = 1;        // 데이터 번호 초기화
      await _getData(_searchQuery.text); // 검색 데이터 받기

      /// 검색을 하였을 시 최근 검색어에 데이터 적재 (이미 검색어가 있다면 적재X)
      if (!_keyword.contains(_searchQuery.text)) {
        _keyword.add(_searchQuery.text); // 검색 결과 배열에 추가
        prefs.setStringList('search', _keyword); // 검색값 넣기
      }
    });
  }

  ///하단으로 스크롤을 내렸을때 데이터 적재 함수
  void _scrollListener() {
    if(!_isLoading!){
      if(_sqlResult.length >= _limit) { // 자료가 30개 이하 일때 스크롤 위아래 움직이다 불필요 자료를 불러 오는 경우를 방지 하기 위함
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          print("여기가 맥스 값");
          setState(() => _isLoading = true);
          _getData(_tem); // 다시 자료 불러 오기
        }
      }
    }
  }

  ///상단으로 올라가기 함수
  void _scrollToTop() {
    _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        // 0.2초만에 올라가기
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn
    );
  }

  ///처음 페이지 진입시 가장 먼저 실행 함수
  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    _getKeyWord(); // 키워드 값을 가져와요
    super.initState();
  }

  ///************************************ 빌드 *************************************///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///뒷배경 컬러
      backgroundColor: AppColor.background,
      ///플로팅 버튼
      floatingActionButton: FloatingCommunity(
          onPressedMovingTop: () {
            _scrollToTop();
          }
      ),
      ///앱바 타이틀
      appBar: AppBar(
        centerTitle: true, //앱바 타이틀 중앙정렬
        backgroundColor: AppColor.white, //앱바 뒷배경 컬러
        automaticallyImplyLeading : false, //뒤로가기 버튼 제거
        elevation: 0.5, //하단 라인 굵기
        bottom: PreferredSize(
          ///앱바 Height 잡기
          preferredSize: Size.fromHeight(appbar),
          ///텍스트 상태관리 (폼키가 값을 잡고 있어줌)
          child: Form(
            key: _formKey,
            child: Container(
              // 검색창 마진
              margin: const EdgeInsets.all(15),
              child: Stack(
                children: [
                  ///텍스트 박스
                  TextFieldBox(
                    controller: _searchQuery,
                    hint: '검색어를 입력해주세요. (2~10자 내외)',
                    maxLength: 10,
                    onChanged: (val) {
                      /// 벨리데이션이 안걸릴 때 검색
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _getKeyWord(); // 키워드 값을 가져와요
                          _onSearchChanged();
                          appbar = 24;
                        });
                      }
                      return null;
                    },
                    validator: (value) {
                      /// 벨리데이션 조건
                      if(value!.isEmpty || value.length <= 1){
                        setState(() {
                          //벨리데이션 텍스트 오버플로우 방지 앱바 height 늘리기
                          appbar = 50;
                        });
                        return '2~8자 내외로 작성해 주세요';
                      }
                      return null;
                    },
                    keyboardType: null,
                  ),
                  ///돋보기 버튼
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.search_rounded, color: AppColor.deepGrey),
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _getKeyWord(); // 키워드 값을 가져와요
                              _onSearchChanged();
                              appbar = 24;
                            });
                          }
                        },
                      )
                  ),
                  ///검색어 삭제
                  Visibility(
                      visible: _searchQuery.text.isNotEmpty,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: IconButton(
                              icon: Icon(Icons.cancel_rounded, color: AppColor.grey, size: 18),
                              onPressed: (){
                                _searchQuery.clear();
                                _getKeyWord(); // 키워드 값을 가져와요
                              },
                            ),
                          )
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ///바디내 영역
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          ///최근검색어
          SliverToBoxAdapter(child: _agoFilter()),
          ///검색한결과
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 150),
              child: StreamBuilder<dynamic>(
                stream: _streamController.stream,
                initialData: null,
                builder: (BuildContext context, snapshot) {
                  ///에러가 났을때의 페이지
                  if (snapshot.hasError){
                    return const ErrorPage();
                  }
                  ///데이터가 Null 페이지
                  if (snapshot.data == null){
                    return const NullPage();
                  }
                  ///데이터가 없을때 페이지
                  if (snapshot.data.isEmpty){
                    return const EmptyPage();
                  }
                  ///데이터가 정상의 페이지
                  switch (snapshot.connectionState) {
                    //데이터가 로드중일때의 로더
                    case ConnectionState.waiting: return const Loader();
                    //기본 그리드
                    default: return _searchGrid(snapshot);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///********************************** 위젯함수 ************************************///

  ///최근검색어
  Widget _agoFilter(){
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("최근검색어", style: AppTextStyle.bText16(AppColor.black)),
              TextButton(
                  child: const Text('전체삭제', style: TextStyle(color: Colors.grey)),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setStringList('search', []); // 모든값 초기화
                    setState(() {
                      _showKeyword = []; // 초기화
                    });
                  },
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(_showKeyword.length, (index) {
              return FilterChoiceChip(
                  data: _showKeyword,
                  idx: index,
                  filterIds: _filterIds,
                  onSelected: (){
                    _initData(_showKeyword[index]);
                  },
              );
            }),
          ),
        )
      ],
    );
  }
  
  ///검색결과 그리드
  Widget _searchGrid(AsyncSnapshot<dynamic> snapshot){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
          child: Text("검색결과", style: AppTextStyle.bText16(AppColor.black)),
        ),
        GridView.builder(
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
          primary: false,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data!.length >= _limit
              ? snapshot.data!.length +1
              : snapshot.data!.length,
          // 로딩 인디케이터 30개 미만일땐 안보여주기 위함
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0, // 수직 패딩
            mainAxisSpacing: 0, // 수평 패딩
          ),
          itemBuilder: (BuildContext context, int index) {
            if (snapshot.data.length == index) {
              // 불러온 값의 맥스 값이 같다면
              return const Loader(); // 인디케이터 보여주세요
            }
            final item = snapshot.data![index];
            //get your item data here ...
            return InkWell(
              splashColor: Colors.transparent, //버튼 클릭 이벤트 삭제
              highlightColor: Colors.transparent, //버튼 클릭 이벤트 삭제
              onTap: () {
                Get.to(ImgPage(ds: item));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                child: ExtendedImage.network(
                  item['image_url'],
                  cacheHeight: listCachedHeight,
                  cacheWidth: listCachedWith,
                  fit: BoxFit.cover,
                  cache: true,
                  // 뒤로 갈때 이미지 리로드 방지
                  gaplessPlayback: true,
                  // 404같은 에러를 만나서 이미지 출력을 할수 없다면
                  loadStateChanged: (ExtendedImageState state) {
                    if (state.extendedImageLoadState == LoadState.failed) {
                      return Container(
                        color: AppColor.grey,
                        child: const Icon(
                          Icons.image_rounded,
                          color: AppColor.deepGrey,
                          size: 40,
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
