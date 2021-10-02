import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
// import 'app_constants.dart';
import 'app_ffi_js.dart';
import 'totem.dart';

Stream<String> fluxStream = fluxController.stream;

void main() {
  appInterops();

  runApp(ConduitApp());
}

class TabBarViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: Colors.black26,
          // title: Text('TabBar Widget'),
          bottom: TabBar(
            indicatorColor: Colors.lime,
            indicatorWeight: 5.0,
            labelColor: Colors.white,
            labelPadding: EdgeInsets.only(top: 4.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'Links',
                icon: Icon(
                  Icons.link,
                  color: Colors.white,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
              //child: Image.asset('images/android.png'),

              Tab(
                text: 'EULA',
                icon: Icon(
                  Icons.business,
                  color: Colors.white,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
              Tab(
                text: 'Privacy',
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: EasyWebView(
                key: ValueKey("Link View"),
                src:
                    "https://publish.obsidian.md/corvox601/006+Corvox-601-Tab-Links",
                onLoaded: () {},
                width: 800,
              ),
            ),
            Center(
                child: EasyWebView(
              key: ValueKey("EULA View"),
              src: "https://publish.obsidian.md/corvox601/EULA",
              onLoaded: () {},
              width: 800,
            )),
            Center(
                child: Text(
              'TBD',
              style: TextStyle(fontSize: 32),
            )),
          ],
        ),
      ),
    );
  }
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
                      width: 900,
                      child: TabBarViewWidget(),
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
                width: 166,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  color: Color.fromARGB(1, 32, 32, 32),
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
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Aaron.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Alex.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Ander.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Fortunato.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Frank.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Hans.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Luni.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Monkia.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Sanjay.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Sharon.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Tawanda.jpg'),
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Image.asset('assets/Img-Michael.jpg'),
                        color: Color.fromRGBO(42, 42, 42, 1),
                      ),
                    ],
                  ))
            ],
          ),
          Container()
        ],
      ),
      // bottomNavigationBar: BottomBarWithSheet(
      //   selectedIndex: 0,
      //   sheetChild: Center(child: Text("Place for other content")),
      //   bottomBarTheme: BottomBarTheme(
      //     mainButtonPosition: MainButtonPosition.middle,
      //     selectedItemIconColor: const Color(0xFF2B65E3),
      //   ),
      //   mainActionButtonTheme: MainActionButtonTheme(
      //     size: 60,
      //     color: const Color(0xFF2B65E3),
      //     icon: Icon(
      //       Icons.add,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //   ),
      //   onSelectItem: (index) => print('item $index was pressed'),
      //   items: [
      //     BottomBarWithSheetItem(label: "EULA", icon: Icons.people),
      //     BottomBarWithSheetItem(label: "Damnit Michael", icon: Icons.people),
      //     BottomBarWithSheetItem(label: "Bene Gesserit", icon: Icons.people),
      //     BottomBarWithSheetItem(
      //         label: "Special thanks to...", icon: Icons.favorite),
      //   ],
      // ),
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
