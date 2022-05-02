import 'package:choose_the_svg/models/enums.dart';
import 'package:choose_the_svg/models/images.dart';
import 'package:choose_the_svg/svg/svg_data.dart';
import 'package:choose_the_svg/svg/svg_data_controller.dart';
import 'package:choose_the_svg/svg/svg_numbers.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final List<Images> images = [
  Images(
    picture: 'lib/assets/images/monitor.png',
    list: monitor,
    type: resourceType.monitor,
  ),
  Images(
    picture: 'lib/assets/images/flower.png',
    list: plants,
    type: resourceType.plants,
  ),
  Images(
    picture: 'lib/assets/images/snowman.png',
    list: snowMan,
    type: resourceType.snowMan,
  ),
];

class SvgScreen extends StatelessWidget {
  SvgScreen({Key? key}) : super(key: key);

  final SvgDataController svgDataController = SvgDataController();

  List<Widget> _buildBody(BuildContext context) {
    final List<Widget> bodyParts = List<Widget>.filled(
      BodySvgData.values.length,
      const Text(''),
      growable: true,
    );
    for (int i = 0; i < BodySvgData.values.length; i++) {
      if (svgDataController.selectedTableResource.value != null) {
        switch (svgDataController.selectedTableResource.value!.type) {
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

  bool verifyShowTableResource(int index, int i) {
    if (!snowMan.contains(BodySvgData.values[i].index) &&
        !plants.contains(BodySvgData.values[i].index)) {
      return true;
    }
    return false;
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
                  onTap: () {
                    svgDataController.verifyPressedPart(bodyParts.index);

                    print(bodyParts.index);
                  },
                  child: Container(
                    //0xFFFF605E
                    color:
                        svgDataController.verifyModifiedColor(bodyParts.index),
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: Listenable.merge([
            svgDataController.showTableOptions,
            svgDataController.selectedTableResource,
            svgDataController.showColorsOptions,
            svgDataController.bodyParts,
          ]),
          builder: (_, __) {
            final showTableOptions = svgDataController.showTableOptions.value;
            final showColorsOptions = svgDataController.showColorsOptions.value;
            return Stack(
              children: [
                Positioned(
                  right: 0,
                  left: (MediaQuery.of(context).size.width / 3),
                  top: 20,
                  bottom: 0,
                  child: const Text(
                    'Selecione a parte que você quer customizar:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                ..._buildBody(context),
                if (showTableOptions)
                  Positioned(
                    right: 0,
                    left: (MediaQuery.of(context).size.width * 0.7),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(top: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: images.map(
                            (image) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    width: 100,
                                    height: 100,
                                    child: GestureDetector(
                                      onTap: () {
                                        svgDataController.selectedTableResource
                                            .value = image;
                                      },
                                      child: Image.asset(image.picture),
                                    ),
                                  ),
                                  if (svgDataController
                                          .selectedTableResource.value?.type ==
                                      image.type)
                                    const Positioned(
                                      right: 0,
                                      left: 0,
                                      top: 20,
                                      bottom: 0,
                                      child: Icon(
                                        Icons.check_circle_outline_rounded,
                                        size: 60,
                                        color: Colors.green,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                if (showColorsOptions)
                  Positioned(
                    right: 0,
                    left: (MediaQuery.of(context).size.width * 0.7),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              right: 35,
                              top: 9,
                            ),
                            child: const Text(
                              'Selecione a cor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              children: svgDataController.colors.map(
                                (color) {
                                  return GestureDetector(
                                    onTap: () {
                                      svgDataController
                                          .verifyIndexAndUpdateColor(color);
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.1,
                                            ),
                                            color: color,
                                          ),
                                        ),
                                        const Positioned(
                                          right: 37,
                                          left: 0,
                                          top: 5,
                                          bottom: 0,
                                          child: Icon(
                                            Icons.check_circle_outline_rounded,
                                            size: 25,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
// TODO: Colors
// svgDataController.colors.map(
//                             (color) {
//                               return Stack(
//                                 children: [
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 20),
//                                     width: 20,
//                                     height: 20,
//                                     color: color,
//                                     child: GestureDetector(
//                                       onTap: () {},
//                                       child: Container(),
//                                     ),
//                                   ),
//                                   // const Positioned(
//                                   //   right: 0,
//                                   //   left: 0,
//                                   //   top: 20,
//                                   //   bottom: 0,
//                                   //   child: Icon(
//                                   //     Icons.check_circle_outline_rounded,
//                                   //     size: 60,
//                                   //     color: Colors.green,
//                                   //   ),
//                                   // ),
//                                 ],
//                               );
//                             },
//                           ).toList(),

class PathPainter extends CustomPainter {
  final BodySvgData bodyParts;
  PathPainter(this.bodyParts);

  @override
  void paint(Canvas canvas, Size size) {
    var path = getPathByBodyPart(bodyParts);
    var color = getColorByBodyPart(bodyParts);
    var isBracketLines = bodyParts.toString() == 'BodyParts.bp_75' ||
        bodyParts.toString() == 'BodyParts.bp_74' ||
        bodyParts.toString() == 'BodyParts.bp_76';

    var isStroke = isBracketLines;
    canvas.drawPath(
        path,
        Paint()
          ..style = isStroke ? PaintingStyle.stroke : PaintingStyle.fill
          ..color = color
          ..strokeWidth = 2.0);
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
