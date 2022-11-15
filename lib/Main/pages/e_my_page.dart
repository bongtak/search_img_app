import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:search_img_app/Main/constants/borders.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/global.dart';
import 'package:search_img_app/Main/constants/shadows.dart';
import 'package:search_img_app/Main/constants/textstyle.dart';
import 'package:search_img_app/Main/widget/element/profileimg.dart';


class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPage createState() => _MyPage();
}

class _MyPage extends State<MyPage> with SingleTickerProviderStateMixin<MyPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 200));
    //await initData();
    HapticFeedback.heavyImpact(); // 햅틱 피드백
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 200));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  dynamic _scrollToTop() {
    // 상단 올라 가기
    return _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn);
    //setState(() => _isOnTop = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              // 스크롤시 고정 또는 안보이게
              pinned: false,
              floating: true,
              // 뒤로가기 제거
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.background,
              title: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Image.asset("img/earth.png"),
                    height: 50,
                  ),
                  Text('세모이', style: AppTextStyle.bText16(AppColor.black))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.fromBorderSide(AppBorder.border1(AppColor.shadow)),
                      boxShadow: [
                        AppShadow.shadowBR(AppColor.shadow)
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    margin : const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin : const EdgeInsets.only(right: 20),
                                  child: const InCardProfileImg(imgPath: 'img/profile.png')
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Brandy 회원님", style: AppTextStyle.bText14(AppColor.black),),
                                  Text("brandi_recruit@greetinghr.com", style: AppTextStyle.nText12(AppColor.black),),
                                  Text("VIP등급", style: AppTextStyle.nText14(AppColor.black),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                              icon: Icon(Icons.settings_rounded, color: AppColor.grey),
                              onPressed: () {msgShow.msgShow("[안내사항]", "더 많은 퍼포먼스를 보시려면\n박소은 개발자를 채용하셔야 합니다 :)");},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                      padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 25),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.fromBorderSide(AppBorder.border1(AppColor.shadow)),
                        boxShadow: [
                          AppShadow.shadowBR(AppColor.shadow)
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      margin : const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      width: double.infinity,
                      child: Column(
                        children: [
                          buildBottomLine('이벤트'),
                          buildBottomLine('나의등급'),
                          buildBottomLine('푸시 알람 설정'),
                          buildBottomLine('자주 묻는 질문'),
                          buildBottomLine('앱 정보'),
                        ],
                      )
                  ),

                  Container(
                      padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 25),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.fromBorderSide(AppBorder.border1(AppColor.shadow)),
                        boxShadow: [
                          AppShadow.shadowBR(AppColor.shadow)
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      margin : const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      width: double.infinity,
                      child: Column(
                        children: [
                          buildBottomLine('공지사항'),
                          buildBottomLine('고객센터'),
                          buildBottomLine('전화문의'),
                          buildBottomLine('1:1문의'),
                          buildBottomLine('챗봇문의'),
                        ],
                      )
                  )
                ],
              )
            ),
            SliverToBoxAdapter(
              child: Stack(children: [

                Container(
                  height: 200,
                  color: AppColor.background,
                ),

                InkWell(
                  onTap: () {
                    _scrollToTop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 130,top: 20),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColor.white,
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ),

              ],),
            ),
          ],
        ),
      )
    );
  }

  Widget buildBottomLine(String title){
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: -0.3,
              ),
            ),
            tileColor: AppColor.white,
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: (){
              msgShow.msgShow("[안내사항]", "더 많은 퍼포먼스를 보시려면\n박소은 개발자를 채용하셔야 합니다 :)");
            },
          ),
            SizedBox(
              height: 2,
              child: Divider(
                thickness: 0.8,
                indent: 0,
                endIndent: 0,
                color: Colors.grey[300],
              ),
            ),
        ],
      ),
    );
  }

}
