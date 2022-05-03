import 'package:choose_the_svg/models/body_part.dart';
import 'package:choose_the_svg/models/enums.dart';
import 'package:choose_the_svg/models/images.dart';
import 'package:choose_the_svg/svg/svg_data.dart';
import 'package:flutter/material.dart';

import 'svg_numbers.dart';

const List<Color> colors = [
  Color(0XFF000000),
  Color(0XFF0000FF),
  Color(0XFF808080),
  Color(0XFF008000),
  Color(0XFF800080),
  Color(0XFFFF0000),
  Color(0XFFFFFFFF),
  Color(0XFFF0F8FF),
  Color(0XFFFF7F50),
  Color(0XFFB22222),
  Color(0XFFFF69B4),
  Color(0XFFFFFACD),
];

class SvgDataController {
  final bodyParts = ValueNotifier<List<BodyPartModel>>([]);
  final selectedIndex = ValueNotifier<int?>(null);
  final showTableOptions = ValueNotifier<bool>(false);
  final showColorsOptions = ValueNotifier<bool>(false);
  final selectedTableResource = ValueNotifier<Images?>(null);

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
    List<BodyPartModel> updateBodyParts = [...bodyParts.value];

    final existsIndex = bodyParts.value.indexWhere(
      (item) => item.listIndex.contains(selectedIndex.value),
    );

    if (bedsideLamp.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: bedsideLamp,
        type: bodyType.bedsideLamp,
        updateBodyParts: updateBodyParts,
      );
    } else if (pillow.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: pillow,
        type: bodyType.pillow,
        updateBodyParts: updateBodyParts,
      );
    } else if (couch.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: couch,
        type: bodyType.couch,
        updateBodyParts: updateBodyParts,
      );
    } else if (hair.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: hair,
        type: bodyType.hair,
        updateBodyParts: updateBodyParts,
      );
    } else if (scarf.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: scarf,
        type: bodyType.scarf,
        updateBodyParts: updateBodyParts,
      );
    } else if (book.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: book,
        type: bodyType.book,
        updateBodyParts: updateBodyParts,
      );
    } else if (legs.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: legs,
        type: bodyType.legs,
        updateBodyParts: updateBodyParts,
      );
    } else if (plants.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: plants,
        type: bodyType.plants,
        updateBodyParts: updateBodyParts,
      );
    } else if (shoes.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: shoes,
        type: bodyType.shoes,
        updateBodyParts: updateBodyParts,
      );
    } else if (mat.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: mat,
        type: bodyType.mat,
        updateBodyParts: updateBodyParts,
      );
    } else if (floor.contains(selectedIndex.value)) {
      updateBodyColor(
        color: color,
        existsIndex: existsIndex,
        list: floor,
        type: bodyType.floor,
        updateBodyParts: updateBodyParts,
      );
    }

    bodyParts.value = updateBodyParts;
  }

  void updateBodyColor({
    required Color color,
    required List<int> list,
    required bodyType type,
    required List<BodyPartModel> updateBodyParts,
    required int existsIndex,
  }) {
    if (existsIndex >= 0) {
      updateBodyParts[existsIndex].color = color;
    } else {
      updateBodyParts.add(
        BodyPartModel(
          color: color,
          listIndex: list,
          typeName: type,
        ),
      );
    }
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

  List<Widget> verifyBodyParts({
    required List<Widget> bodyParts,
    required BuildContext context,
  }) {
    for (int i = 0; i < BodySvgData.values.length; i++) {
      if (selectedTableResource.value != null) {
        switch (selectedTableResource.value!.type) {
          case resourceType.monitor:
            if (!snowMan.contains(BodySvgData.values[i].index) &&
                !plants.contains(BodySvgData.values[i].index)) {
              bodyParts[i] = _buildBodyPart(
                BodySvgData.values[i],
                context,
              );
            }
            break;
          case resourceType.snowMan:
            if (!monitor.contains(BodySvgData.values[i].index) &&
                !plants.contains(BodySvgData.values[i].index)) {
              bodyParts[i] = _buildBodyPart(
                BodySvgData.values[i],
                context,
              );
            }
            break;
          case resourceType.plants:
            if (!snowMan.contains(BodySvgData.values[i].index) &&
                !monitor.contains(BodySvgData.values[i].index)) {
              bodyParts[i] = _buildBodyPart(
                BodySvgData.values[i],
                context,
              );
            }
            break;
        }
      } else {
        if (!snowMan.contains(BodySvgData.values[i].index) &&
            !plants.contains(BodySvgData.values[i].index) &&
            !monitor.contains(BodySvgData.values[i].index)) {
          bodyParts[i] = _buildBodyPart(
            BodySvgData.values[i],
            context,
          );
        }
      }
    }
    return bodyParts;
  }

  Widget _buildBodyPart(BodySvgData bodyParts, BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 600,
        child: ClipPath(
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: <Widget>[
              CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: PathPainter(
                  bodyParts,
                ),
                child: const FittedBox(),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => verifyPressedPart(bodyParts.index),
                  child: Container(
                    //0xFFFF605E
                    color: verifyModifiedColor(bodyParts.index),
                  ),
                ),
              )
            ],
          ),
          clipper: PathClipper(bodyParts),
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final BodySvgData bodyParts;
  PathPainter(this.bodyParts);

  @override
  void paint(Canvas canvas, Size size) {
    var path = getPathByBodyPart(bodyParts);
    var color = getColorByBodyPart(bodyParts);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color
        ..strokeWidth = 2.0,
    );
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PathPainter oldDelegate) => false;
}

class PathClipper extends CustomClipper<Path> {
  final BodySvgData bodyParts;
  PathClipper(this.bodyParts);

  @override
  Path getClip(Size size) {
    return getPathByBodyPart(bodyParts);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
