import 'package:flutter/material.dart';

class BackgroundDesign extends StatelessWidget {
  final Widget child;
  const BackgroundDesign({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return CustomPaint(
      painter: BackgroundDesignPainter(screenSize),
      child: child,
      size: screenSize,
    );
  }
}

class BackgroundDesignPainter extends CustomPainter {
  final Size _size;
  BackgroundDesignPainter(this._size);
  @override
  void paint(Canvas canvas, Size size) {
    final bigCircle = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0xFFA2E0E4).withOpacity(.2);

    final smallCircle = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0xFFA2E0E4).withOpacity(.5);

    canvas.drawCircle(
        Offset(_size.width, _size.height * 0.3), _size.height * 0.2, bigCircle);

    canvas.drawCircle(
        Offset(0, _size.height), _size.height * 0.09, smallCircle);
  }

  @override
  bool shouldRepaint(BackgroundDesignPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackgroundDesignPainter oldDelegate) => false;
}
