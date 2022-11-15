import 'package:flutter/material.dart';
import 'package:search_img_app/Main/constants/colors.dart';

class TextFieldBox extends StatefulWidget {
  const TextFieldBox({
    Key? key,
    required this.controller, //컨트롤러
    required this.hint, // 내부 힌트 텍스트
    required this.maxLength, //최대 길이
    required this.onChanged, // 온체인지 조건
    required this.validator, // 벨리데이션 조건
    required this.keyboardType, //키보드 타입
  }) : super(key: key);
  final TextEditingController controller; //컨트롤러
  final String hint; // 내부 힌트 텍스트
  final int? maxLength; //최대 길이
  final String? Function(String?)? onChanged; // 온체인지 조건
  final String? Function(String?)? validator; // 벨리데이션 조건
  final TextInputType? keyboardType; //키보드 타입

  @override
  State<TextFieldBox> createState() => _TextFieldBoxState();
}

class _TextFieldBoxState extends State<TextFieldBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength, // 최대 길이
      controller: widget.controller..text, // 컨트롤러
      keyboardType: widget.keyboardType, // 키보드 타입
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          counterText: "", // 하단왼쪽에 길이제한 표기삭제
          hintText: widget.hint, // 내부에 적혀있는 힌트 텍스트
          hintStyle : const TextStyle(height: 1.5, color: AppColor.deepGrey, fontSize: 14), // 힌트 텍스트 스타일
          filled: true, // 전체적인 영역 네모
          fillColor: AppColor.white, // 네모 컬러
          contentPadding: const EdgeInsets.only(left: 10, right: 10), // 내부 패딩
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1), // 영역 라운드
          )
      ),
      onChanged: widget.onChanged, //값 저장
      validator: widget.validator, // 벨리데이션 조건
    );
  }


}
