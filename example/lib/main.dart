import 'package:flutter/material.dart';

import 'package:sprung/sprung.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprung Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Sprung Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _toggleOffset method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(24.0),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SprungBox(
              title: "under",
              curve: Sprung.underDamped,
            ),
            SprungBox(
              title: "critically",
              curve: Sprung.criticallyDamped,
            ),
            SprungBox(
              title: "over",
              curve: Sprung.overDamped,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SprungBox extends StatefulWidget {
  final String title;
  final Curve curve;
  final Duration duration;

  SprungBox({
    @required this.title,
    @required this.curve,
    duration,
  }) : this.duration = duration ?? Duration(milliseconds: 700);

  @override
  _SprungBoxState createState() => _SprungBoxState();
}

class _SprungBoxState extends State<SprungBox> {
  bool _isOffset = false;

  void _toggleOffset() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      this._isOffset = !this._isOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final text = widget.title;
        final top = this._isOffset ? height - 200.0 : 100.0;

        final width = MediaQuery.of(context).size.width / 3 - 30;

        return GestureDetector(
          onTap: _toggleOffset,
          child: AnimatedContainer(
            duration: this.widget.duration,
            curve: widget.curve,
            margin: EdgeInsets.only(
              top: top,
            ),
            height: width,
            width: width,
            color: Colors.pinkAccent,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
