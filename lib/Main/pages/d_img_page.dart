import 'package:date_time_format/date_time_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/textstyle.dart';

class ImgPage extends StatefulWidget {
  const ImgPage({
    Key? key,
    required this.ds, // 데이터 쉐어링
  }) : super(key : key);
  final Map ds; // 데이터 쉐어링

  @override
  State<ImgPage> createState() => _ImgPageState();
}

class _ImgPageState extends State<ImgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            /// 이미지 및 내용
            SizedBox(
              height: Get.height,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExtendedImage.network(
                        widget.ds['image_url'],
                        // 사진 용량 줄이기
                        // cacheHeight: listCachedHeight,
                        // cacheWidth: listCachedWith,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        cache: true,
                        gaplessPlayback: true,
                        // 뒤로 갈때 이미지 리로드 방지
                        // 404같은 에러를 만나서 이미지 출력을 할수 없다면
                        loadStateChanged: (ExtendedImageState state) {
                          if (state.extendedImageLoadState == LoadState.failed) {
                            return Container(
                              width: Get.width,
                              height: Get.width,
                              color: AppColor.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image_rounded, color: AppColor.black, size: 60),
                                  Text("No Image", style: AppTextStyle.nText14(AppColor.black)),
                                ],
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      if(widget.ds['display_sitename'].isNotEmpty)
                        Text('이미지 출처 : ${widget.ds['display_sitename']}',style: AppTextStyle.nText16(AppColor.white)),
                      if(widget.ds['datetime'].isNotEmpty)
                        Text(
                          "문서 작성 시간 : ${DateTimeFormat.format(DateTime.parse(widget.ds['datetime'].toString()).subtract(const Duration(hours: 9)), format: 'y-m-d(D) H:i:s')}\n",
                          style: AppTextStyle.nText16(AppColor.white)
                        ),
                    ],
                  ),
                ),
              ),
            ),
            /// 상단 왼쪽의 플로팅 버튼 (뒤로가기)
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              width: 40,
              height: 40,
              child: FloatingActionButton(
                  onPressed: () {
                    Get.back();
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
