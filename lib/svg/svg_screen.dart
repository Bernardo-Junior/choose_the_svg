import 'package:choose_the_svg/svg/svg_data.dart';

import 'package:flutter/material.dart';

class SvgScreen extends StatelessWidget {
  const SvgScreen({Key? key}) : super(key: key);

  List<Widget> _buildBody() {
    final List<Widget> bodyParts = List<Widget>.filled(
      BodySvgData.values.length,
      const Text(''),
      growable: true,
    );
    for (int i = 0; i < BodySvgData.values.length; i++) {
      bodyParts[i] = _buildBodyPart(BodySvgData.values[i]);
    }
    return bodyParts;
  }

  Widget _buildBodyPart(BodySvgData bodyParts) {
    return ClipPath(
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
              onTap: () {},
              child: Container(
                //0xFFFF605E
                color: Colors.transparent,
              ),
            ),
          )
        ],
      ),
      clipper: PathClipper(bodyParts),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ClipPath(
            child: Container(
              padding: EdgeInsets.only(right: 200),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                child: Container(
                  color: Colors.red,
                  width: 0,
                  height: 500,
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        ..._buildBody(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
