import 'dart:math';
import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Totem extends StatefulWidget {
  final Stream<String> stream;
  Totem({this.stream});
  @override
  _TotemState createState() => _TotemState();
}

// This widget should manage its own state!
class _TotemState extends State<Totem> with TickerProviderStateMixin {
  //https://api.flutter.dev/flutter/animation/AnimationController-class.html
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
    List<dynamic> _totemState(String state) {
      // WASM Candidate
      List<String> functional = state.split(",");
      int polarity = functional.indexOf("true");
      // -1: 0 polarity
      //  1: 1 polarity
      //  2:-1 polarity
      int length =
          int.parse(functional[0]); //For performance or additional behavior
      functional = functional.sublist(3);
      List<int> totemState = functional.map((e) => e.codeUnitAt(0)).toList();

      // Normalize Codeblock
      final lower = totemState.reduce(min);
      final upper = totemState.reduce(max);
      final List<double> normalized = [];
      totemState.forEach((element) => element < 0.5
          ? normalized.add(-(element / lower))
          : normalized.add(element / upper));

      print("$totemState => $normalized");
      // normalized.add(polarity.toDouble());
      return [
        polarity,
        length,
        normalized,
      ];
    }

    //https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html
    return StreamBuilder<String>(
        stream: widget.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          var state = '';
          if (snapshot.hasData) {
            state = snapshot.data;
            List<dynamic> dialState = _totemState(state);
            List<AnimationController> controller = [
              _controller0,
              _controller1,
              _controller2
            ];
            Iterator<double> dialIn = dialState[2].iterator;
            Duration loopTime = Duration(seconds: 5) ~/ dialState[1];
            for (double turn in dialState.skip(2)) {
              Iterator<AnimationController> controllers = controller.iterator;
              while (dialIn.moveNext() && controllers.moveNext()) {
                // determine polarity based on mapping
                // Consider Curves(Cubic()), TransitionBuilder
                switch (dialState[0]) {
                  case 0:
                    // Neutral
                    controllers.current.forward(from: dialIn.current);
                    break;
                  case 1:
                    // Positive
                    controllers.current
                        .animateTo(dialIn.current, duration: loopTime);
                    break;
                  case 2:
                    // Negative
                    controllers.current
                        .animateBack(dialIn.current, duration: loopTime);
                    break;
                }
              }
              if (!dialIn.moveNext()) {
                break;
              }
            }
            // controller.forEach((element) {
            //   element.repeat();
            // });
          }
          //https://api.flutter.dev/flutter/animation/AnimationController-class.html
          return AnimatedBuilder(
              animation: _controller0,
              builder: (context, child) {
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
        // debugPrint("drawAxis Error: $e");
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
