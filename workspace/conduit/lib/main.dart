import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';

import 'app_constants.dart';
import 'app_ffi_js.dart';
import 'totem.dart';

Stream<String> fluxSream = fluxController.stream;

void main() {
  appInterops();

  runApp(ConduitApp());
}

class ConduitApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corvox Conduit',
      theme: ThemeData.dark(),
      home: ConduitHomePage(title: 'Corvox Conduit'),
    );
  }
}

class ConduitHomePage extends StatefulWidget {
  ConduitHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ConduitHomePageState createState() => _ConduitHomePageState();
}

const int tSampleRate = 44000;

class _ConduitHomePageState extends State<ConduitHomePage> {
  bool _recording = false;
  //RealtimeDataService _dataService = locator<RealtimeDataService>();
  void _toggleRecording() {
    //_dataService.isRunning ? _dataService.stop() : _dataService.start();
    _recording = !_recording;
    var _timer = Timer.periodic(new Duration(minutes: 9), (timer) {
      refreshToken();
    });
    _recording ? listenToVoice() : {stopListening(), _timer.cancel()};
    setState(() {
      _timer = _timer;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              login;
              print("button pressed");
            },
            child: const Text('Login'),
          )
        ],
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColorDark,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
            ),
            SizedBox(
              height: 300,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.loose,
                children: <Widget>[
                  Totem(),
                  CustomPaint(
                    painter: ButtonRing(Colors.black, 100.0),
                    child: RecordingButton(_toggleRecording),
                    foregroundPainter: ButtonRing(Colors.white, 90.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function for totem translation here
// Use

class ButtonRing extends CustomPainter {
  final Color customColor;
  final double size;
  ButtonRing(this.customColor, this.size);

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = customColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        width: this.size, //size.width,
        height: this.size, //size.height,
      ),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RecordingButton extends StatefulWidget {
  RecordingButton(this.toggle);
  final VoidCallback toggle;
  _RecordingButtonState createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  bool recording = true;
  Color color;
  double borderRadius;
  double margin;
  double box;

  @override
  void initState() {
    super.initState();
    color = Colors.red;
    borderRadius = 50.0;
    margin = 40;
    box = 40.0;
  }

  void _changeShape() {
    setState(() {
      recording = !recording;
    });
  }

  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.all(recording ? margin : margin + 8),
      width: recording ? 85.0 : box,
      height: recording ? 85.0 : box,
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        // You can add a border here!
        color: Colors.red,
        borderRadius: BorderRadius.circular(recording ? borderRadius : 8),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          onTap: () {
            widget.toggle();
            _changeShape();
          },
        ),
      ),
    );
  }
}
