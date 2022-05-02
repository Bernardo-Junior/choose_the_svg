import 'package:choose_the_svg/models/body_part.dart';
import 'package:choose_the_svg/models/enums.dart';
import 'package:choose_the_svg/models/images.dart';
import 'package:flutter/material.dart';

import 'svg_numbers.dart';

class SvgDataController {
  final bodyParts = ValueNotifier<List<BodyPartModel>>([]);
  final selectedIndex = ValueNotifier<int?>(null);
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
  void verifyPressedPart(int index) {
    if (table.contains(index)) {
      showColorsOptions.value = false;
      showTableOptions.value = true;
    } else {
      selectedIndex.value = index;
      showTableOptions.value = false;
      showColorsOptions.value = true;
    }
  }

  void verifyIndexAndUpdateColor(Color color) {
    final updateBodyParts = [...bodyParts.value];
    final existsIndex = bodyParts.value.indexWhere(
      (item) => item.listIndex.contains(selectedIndex.value),
    );
    if (bedsideLamp.contains(selectedIndex.value)) {
      if (existsIndex >= 0) {
        updateBodyParts[existsIndex].color = color;
      } else {
        updateBodyParts.add(
          BodyPartModel(
            color: color,
            listIndex: bedsideLamp,
            typeName: bodyType.bedsideLamp,
          ),
        );
      }
    } else if (pillow.contains(selectedIndex.value)) {
      if (existsIndex >= 0) {
        updateBodyParts[existsIndex].color = color;
      } else {
        updateBodyParts.add(
          BodyPartModel(
            color: color,
            listIndex: pillow,
            typeName: bodyType.pillow,
          ),
        );
      }
    }

    bodyParts.value = updateBodyParts;
  }

  Color verifyModifiedColor(int index) {
    if (bodyParts.value.isNotEmpty) {
      final indexPart = bodyParts.value.indexWhere(
        (item) => item.listIndex.contains(index),
      );

      if (indexPart >= 0) {
        return bodyParts.value[indexPart].color;
      }
    }
    return Colors.transparent;
  }
}
