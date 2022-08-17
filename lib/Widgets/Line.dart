import 'package:flutter/material.dart';

class Line extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LineState();
}

class _LineState extends State<Line> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation ;

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(duration: Duration(milliseconds: 3000), vsync: this);

         animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter:LinePainter(_progress));
  }
}

class LinePainter extends CustomPainter {
  late Paint _paint;
  double _progress;

  LinePainter(this._progress) {
    _paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 8.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(200.0, 0.0), Offset(size.width - size.width * _progress, size.height - size.height * _progress), _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}