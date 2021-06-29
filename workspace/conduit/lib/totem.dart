import 'dart:math';
import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Totem extends StatefulWidget {
  @override
  _TotemState createState() => _TotemState();
}

// This widget should manage its own state!
class _TotemState extends State<Totem> with TickerProviderStateMixin {
  AnimationController _controller0;
  AnimationController _controller1;
  AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller0 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 12),
    );
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 16),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
    _controller0.repeat();
    _controller1.repeat();
    _controller2.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller0,
        builder: (context, snapshot) {
          return Center(
            child: CustomPaint(
              painter: AtomPaint(
                value: _controller0.value,
                value1: _controller1.value,
                value2: _controller2.value,
              ),
            ),
          );
        });
    // floatingActionButton: FloatingActionButton(
    //   child: Icon(Icons.play_arrow),
    //   onPressed: () {
    //     _controller.reset();
    //     _controller1.reset();
    //     _controller2.reset();
    //     _controller.repeat();
    //     _controller1.repeat();
    //     _controller2.repeat();
    //   },
    // ),
  }
}

class AtomPaint extends CustomPainter {
  AtomPaint({
    this.value,
    this.value1,
    this.value2,
  });

  final double value, value1, value2;

  Paint _axisPaint = Paint()
    ..color = const Color(0xFFE6E6E6)
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;

  Paint _squarePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    drawAxis(value, canvas, 60, Paint()..color = Colors.white);
    drawAxis(value1, canvas, 100, Paint()..color = Colors.white);
    drawAxis(value2, canvas, 140, Paint()..color = Colors.white);
    drawAxis(value, canvas, 180, Paint()..color = Colors.white);
    drawAxis(value1, canvas, 220, Paint()..color = Colors.white);
    drawAxis(value2, canvas, 260, Paint()..color = Colors.white);
  }

  drawAxis(double value, Canvas canvas, double radius, Paint paint) {
    var firstAxis = getCirclePath(radius);
    canvas.drawPath(firstAxis, _axisPaint);
    UI.PathMetrics pathMetrics = firstAxis.computeMetrics();
    final int count = radius ~/ 10;
    for (UI.PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0,
        pathMetric.length * value,
      );
      try {
        Matrix4 matrix = Matrix4.identity();
        double cycle = 2 * pi;
        matrix.rotateZ(cycle / count);
        for (int i = 0; i < count; i++) {
          // TODO: Precompute Path Metrics
          extractPath = extractPath.transform(matrix.storage);
          var metric = extractPath.computeMetrics().first;
          final offset = metric.getTangentForOffset(metric.length).position;
          canvas.drawRect(
              Rect.fromCenter(
                center: offset,
                width: 20.0,
                height: 20.0,
              ),
              paint);
        }
      } catch (e) {
        debugPrint("drawAxis Error: $e");
      }
    }
  }

  Path getCirclePath(double radius) =>
      Path()..addOval(Rect.fromCircle(center: Offset(0, 0), radius: radius));

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
