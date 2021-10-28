import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:easy_web_view/easy_web_view.dart';
// import 'app_constants.dart';
import 'app_ffi_js.dart';
import 'totem.dart';

const _url1 = 'https://www.linkedin.com/in/micalco/';
const _url2 = 'https://www.linkedin.com/in/frankismartinez/';
const _url3 = 'https://www.linkedin.com/in/aaronrose/';
const _url4 = 'https://www.linkedin.com/in/hhanspal/';
const _url5 = 'https://www.linkedin.com/in/monika-aring-11808b2/';
const _url6 = 'https://www.linkedin.com/in/dr-alex-cahana-health-blockchanger/';
const _url7 = 'https://www.linkedin.com/in/andrew-kgorane-804284109/';
const _url8 = 'https://www.linkedin.com/in/tawanda-chabikwa/';
const _url9 = 'https://www.linkedin.com/in/boldingbroke/';
const _url0 = 'https://www.linkedin.com/in/lunarmobiscuit/';
const _url11 = 'https://www.linkedin.com/in/sanjay-joshi-271508/';
const _url12 = 'https://www.linkedin.com/in/ericrasmussenmd/';
const _url13 = 'https://www.linkedin.com/in/aaronrose/';
const _url14 = 'https://www.linkedin.com/in/anderdobo/';
const _url15 = 'https://www.linkedin.com/in/fortunato911/';
const _url21 = 'https://www.linkedin.com/in/ericrasmussenmd/';

Stream<String> fluxStream = fluxController.stream;

void main() {
  appInterops();

  runApp(ConduitApp());
}

class ConduitApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corvox Conduit for 601',
      theme: ThemeData.dark(),
      home: ConduitHomePage(title: 'Corvox Conduit for 601'),
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
              logout();
            },
            child: const Text('Logout'),
          )
        ],
        backgroundColor: Color.fromARGB(1, 39, 39, 39),
      ),
      backgroundColor: Color.fromRGBO(42, 42, 42, 1),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 800,
                    width: 840,
                    child: EasyWebView(
                      key: ValueKey("Main View"),
                      src:
                          'https://publish.obsidian.md/corvox601/001+Corvox-601-Main',
                      onLoaded: () {
                        // You could choose to edit the html layout this way
                      },
                      height: 800,
                      width: 800,
                    ),
                  ),
                ),
                Container(
                  child: Expanded(
                    flex: 3,
                    child: Container(
                      height: 500,
                      width: 300,
//                      child: TabBarViewWidget(),
                    ),
                  ),
                ),
              ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                height: 8,
                width: 250,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  color: Color.fromRGBO(42, 42, 42, 1),
                ),
                width: 250,
                height: 250,
                child: SizedBox(
//                    This is Recording Button Code, don't edit in here.
                  height: 150,
                  width: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.loose,
                    children: <Widget>[
                      Totem(
                        stream: fluxStream,
                      ),
                      CustomPaint(
                        painter: ButtonRing(Colors.black, 100.0),
                        child: RecordingButton(_toggleRecording),
                        foregroundPainter: ButtonRing(Colors.white, 90.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 750,
                  width: 250,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: <Widget>[
                      ProfileCard(
                          imagePath: 'assets/Img-Michael.jpg',
                          onTap: () => _launchUrl(_url1)),
                      ProfileCard(
                          imagePath: 'assets/Img-Fortunato.jpg',
                          onTap: () => _launchUrl(_url15)),
                      ProfileCard(
                          imagePath: 'assets/Img-Aaron.jpg',
                          onTap: () => _launchUrl(_url3)),
                      ProfileCard(
                          imagePath: 'assets/Img-Alex.jpg',
                          onTap: () => _launchUrl(_url6)),
                      ProfileCard(
                          imagePath: 'assets/Img-Andrew.jpg',
                          onTap: () => _launchUrl(_url7)),
                      ProfileCard(
                          imagePath: 'assets/Img-Ander.jpg',
                          onTap: () => _launchUrl(_url14)),
                      ProfileCard(
                          imagePath: 'assets/Img-Eric.jpg',
                          onTap: () => _launchUrl(_url12)),
                      ProfileCard(
                          imagePath: 'assets/Img-Frank.jpg',
                          onTap: () => _launchUrl(_url2)),
                      ProfileCard(
                          imagePath: 'assets/Img-Hans.jpg',
                          onTap: () => _launchUrl(_url4)),
                      ProfileCard(
                          imagePath: 'assets/Img-Luni.jpg',
                          onTap: () => _launchUrl(_url0)),
                      ProfileCard(
                          imagePath: 'assets/Img-Monkia.jpg',
                          onTap: () => _launchUrl(_url5)),
                      ProfileCard(
                          imagePath: 'assets/Img-Sanjay.jpg',
                          onTap: () => _launchUrl(_url11)),
                      ProfileCard(
                          imagePath: 'assets/Img-Sharon.jpg',
                          onTap: () => _launchUrl(_url9)),
                      ProfileCard(
                          imagePath: 'assets/Img-Tawanda.jpg',
                          onTap: () => _launchUrl(_url8)),
                      ProfileCard(
                          imagePath: 'assets/Img-Eric.jpg',
                          onTap: () => _launchUrl(_url21)),
                    ],
                  ))
            ],
          ),
          Container()
        ],
      ),
    );
  }
}

// Function for Image URLs here

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const ProfileCard({
    this.imagePath,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        child: Image.asset(imagePath),
        color: Colors.black,
      ),
    );
  }
}

_launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
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
      ..strokeWidth = 1
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
    color = Colors.green;
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
        color: Colors.green,
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
