import 'package:choose_the_svg/models/images.dart';
import 'package:flutter/material.dart';

import 'svg_numbers.dart';

class SvgDataController {
  final showTableOptions = ValueNotifier<bool>(false);
  final showColorsOptions = ValueNotifier<bool>(false);
  final selectedTableResource = ValueNotifier<Images?>(null);
  final List<Color> colors = [
    const Color(0XFF000000),
    const Color(0XFF0000FF),
    const Color(0XFF808080),
    const Color(0XFF008000),
    const Color(0XFF800080),
    const Color(0XFFFF0000),
    const Color(0XFFFFFFFF),
    const Color(0XFFF0F8FF),
    const Color(0XFFFF7F50),
    const Color(0XFFB22222),
    const Color(0XFFFF69B4),
    const Color(0XFFFFFACD),
  ];
  void verifySelectedPart(int index) {
    if (table.contains(index)) {
      showColorsOptions.value = false;
      showTableOptions.value = true;
    } else {
      showTableOptions.value = false;
      showColorsOptions.value = true;
    }
  }
}
