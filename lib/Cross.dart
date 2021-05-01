import 'package:flutter/material.dart';

class Cross extends StatefulWidget {
  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> with TickerProviderStateMixin {
  double _progress1 = 0.0;
  Animation<double> animation1;
  AnimationController _controller1;
  double _progress2 = 0.0;
  Animation<double> animation2;
  AnimationController _controller2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    animation1 = Tween(begin: 0.0, end: 1.0).animate(_controller1)
      ..addListener(() {
        setState(() {
          _progress1 = animation1.value;
        });
      });

    _controller1.forward().whenComplete(() {
      _controller2 = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
      );
      animation2 = Tween(begin: 0.0, end: 1.0).animate(_controller2)
        ..addListener(() {
          setState(() {
            _progress2 = animation2.value;
          });
        });

      _controller2.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomPaint(
              painter: CrossPainter(
                _progress1,
                _progress2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

class CrossPainter extends CustomPainter {
  Paint _paint;
  final double _progress1;
  final double _progress2;

  CrossPainter(
    this._progress1,
    this._progress2,
  ) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(0.0, 0.0),
      Offset(
        size.width * _progress1,
        size.height * _progress1,
      ),
      _paint,
    );
    if (_progress2 > 0)
      canvas.drawLine(
        Offset(size.width, 0.0),
        Offset(
          size.height * (1 - _progress2),
          size.width * (_progress2),
        ),
        _paint,
      );
  }

  @override
  bool shouldRepaint(CrossPainter oldDelegate) {
    return true;
  }
}
