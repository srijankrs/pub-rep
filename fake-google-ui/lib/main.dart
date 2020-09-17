import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Gmail',
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Images',
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Icon(Icons.apps, size: 25.0, color: Colors.black54),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  decoration: BoxDecoration(
                      color: Color(0xff4285f4),
                      borderRadius: BorderRadius.all(Radius.circular(3.0))),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
              ],
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              child: Image(
                image: AssetImage('images/google.png'),
                height: 120.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              child: Container(
                  height: 356.0,
                  width: 600.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(23.0)),
                      border: Border.all(color: Colors.black12),
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0.0, 2.5)),
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.black38,
                            size: 21.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 455.0,
                            child: Text('how easy is it'),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.clear,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 1.0,
                            height: 26.0,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          Image(
                            image: AssetImage('images/mic.png'),
                            height: 27.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                        height: 1.0,
                        color: Colors.black12,
                      ),
                      Options("how easy it is ", "to get pregnant"),
                      Options("how easy it is ", "to get hiv"),
                      Options("how easy it is ", "to get pregnant"),
                      Options("how easy it is ", "to get hiv"),
                      Options("how easy it is ", "to get pregnant"),
                      Options("how easy it is ", "to get hiv"),
                      Options("how easy it is ", "to get pregnant"),
                      Options("how easy it is ", "to get hiv"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0))),
                              child: Text(
                                'Google Search',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0))),
                              child: Text(
                                "I'm Feeling Lucky",
                                style: TextStyle(color: Colors.black87),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      )),
    );
  }
}

class Options extends StatelessWidget {
  String text1, text2;

  Options(this.text1, this.text2);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: Row(
        children: [
          SizedBox(
            width: 15.0,
          ),
          Icon(
            Icons.search,
            color: Colors.black38,
            size: 21.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
              width: 470.0,
              child: Row(children: [

                Text(
                  text1,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                Text(text2,style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              ])),
        ],
      ),
    );
  }
}
