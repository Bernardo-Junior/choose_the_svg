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
    return svgDataController.verifyBodyParts(
      bodyParts: bodyParts,
      context: context,
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
            svgDataController.selectedIndex,
          ]),
          builder: (_, __) {
            final showTableOptions = svgDataController.showTableOptions.value;
            final showColorsOptions = svgDataController.showColorsOptions.value;
            return Stack(
              children: [
                Positioned(
                  right: 0,
                  left: (MediaQuery.of(context).size.width / 3),
                  top: 27,
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
                              top: 15,
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
                              padding: const EdgeInsets.only(
                                left: 40,
                                right: 40,
                              ),
                              children: colors.map(
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
                                        if (svgDataController
                                                    .selectedIndex.value !=
                                                null &&
                                            svgDataController
                                                    .verifyModifiedColor(
                                                        svgDataController
                                                            .selectedIndex
                                                            .value!) ==
                                                color)
                                          const Positioned(
                                            right: 37,
                                            left: 0,
                                            top: 5,
                                            bottom: 0,
                                            child: Icon(
                                              Icons
                                                  .check_circle_outline_rounded,
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
