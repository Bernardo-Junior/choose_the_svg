import 'package:flutter/material.dart';

import 'enums.dart';

class BodyPartModel {
  final List<int> listIndex;
  final bodyType typeName;
  Color color;

  BodyPartModel({
    required this.listIndex,
    required this.typeName,
    required this.color,
  });
}
