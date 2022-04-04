import 'package:choose_the_svg/svg/svg_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const images = [
  'lib/assets/images/monitor.png',
  'lib/assets/images/flower.png',
  'lib/assets/images/snowman.png'
];

class SvgScreen extends StatelessWidget {
  const SvgScreen({Key? key}) : super(key: key);

  List<Widget> _buildBody(BuildContext context) {
    final List<Widget> bodyParts = List<Widget>.filled(
      BodySvgData.values.length,
      const Text(''),
      growable: true,
    );
    for (int i = 0; i < BodySvgData.values.length; i++) {
      bodyParts[i] = _buildBodyPart(BodySvgData.values[i], context);
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
                  onTap: () {
                    print(bodyParts.index);
                  },
                  child: Container(
                    //0xFFFF605E
                    color: Colors.transparent,
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
        child: Stack(
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
                        return SizedBox(
                          width: 100,
                          height: 150,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(image),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
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
