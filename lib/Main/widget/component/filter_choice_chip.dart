import 'package:flutter/material.dart';
import 'package:search_img_app/Main/constants/colors.dart';
import 'package:search_img_app/Main/constants/textstyle.dart';

class FilterChoiceChip extends StatefulWidget {
  const FilterChoiceChip({
    Key? key,
    required this.data,
    required this.filterIds,
    required this.onSelected,
    required this.idx,
  }) : super(key: key);
  final List<String> data; //라벨
  final List<String> filterIds; //최종 선택 필터
  final Function onSelected; //최종 선택 필터
  final int idx; //인덱스 번호

  @override
  State<FilterChoiceChip> createState() => _FilterChoiceChipState();
}

class _FilterChoiceChipState extends State<FilterChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: widget.idx == 0 ? 20 : 0, right: widget.idx == widget.data.length-1 ? 20 : 5),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: ChoiceChip(
        selectedShadowColor: AppColor.white,
        backgroundColor: AppColor.white,
        selectedColor: AppColor.grey,
        label: Text(widget.data[widget.idx], style: AppTextStyle.bText12(AppColor.black)),
        selected: widget.filterIds.contains(widget.data[widget.idx]),
        // 필터 배열안에 인덱스 항목이 포함되어있는지 여부를 보고 선택 되었는지 안되었는지 판단
        onSelected: (bool selected) async {
          if (selected) {
            widget.onSelected();
          } // 데이터 초기화
        },
      ),
    );
  }
}
