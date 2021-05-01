import 'package:flutter/material.dart';

class Line extends StatefulWidget {
  int from;
  int to;
  Line({
    Key key,
    @required this.from,
    @required this.to,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => LineState();
}

class LineState extends State<Line> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(
        widget.from,
        widget.to,
        _progress,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LinePainter extends CustomPainter {
  int from;
  int to;
  Paint _paint;
  double _progress;

  LinePainter(
    this.from,
    this.to,
    this._progress,
  ) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  //  GRID
  //  0 1 2
  //  3 4 5
  //  6 7 8

  @override
  void paint(Canvas canvas, Size size) {
    if (from == 0 && to == 2) {
      // Horizontal
      canvas.drawLine(
        Offset(0.0, 0.0),
        Offset(size.width * _progress, 0.0),
        _paint,
      );
    } else if (from == 3 && to == 5) {
      // Horizontal
      canvas.drawLine(
        Offset(0.0, size.height / 2),
        Offset(size.width * _progress, size.height / 2),
        _paint,
      );
    } else if (from == 6 && to == 8) {
      // Horizontal
      canvas.drawLine(
        Offset(0.0, size.height),
        Offset(size.width * _progress, size.width),
        _paint,
      );
    } else if (from == 0 && to == 8) {
      // Diagonal
      canvas.drawLine(
        Offset(0.0, 0.0),
        Offset(
          size.width * _progress,
          size.height * _progress,
        ),
        _paint,
      );
    } else if (from == 2 && to == 6) {
      // Diagonal
      canvas.drawLine(
        Offset(size.width, 0.0),
        Offset(
          size.height * (1 - _progress),
          size.width * (_progress),
        ),
        _paint,
      );
    } else if (from == 0 && to == 6) {
      // Vertical
      canvas.drawLine(
        Offset(0.0, 0.0),
        Offset(0.0, size.height * _progress),
        _paint,
      );
    } else if (from == 1 && to == 7) {
      // Vertical
      canvas.drawLine(
        Offset(size.width / 2, 0.0),
        Offset(size.width / 2, size.height * _progress),
        _paint,
      );
    } else if (from == 2 && to == 8) {
      // Vertical
      canvas.drawLine(
        Offset(size.width, 0.0),
        Offset(size.width, size.height * _progress),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
