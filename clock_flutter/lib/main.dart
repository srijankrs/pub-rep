import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: MyPainter(),
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    super.initState();
  }
}

class MyPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    double width = 25;
    var now = new DateTime.now();

    double centerX = size.width/2;
    double centerY = size.height/2;

    Paint secondPaint = Paint()..color=Colors.greenAccent..strokeWidth=width..strokeCap=StrokeCap.round..style=PaintingStyle.stroke;
    Paint minutePaint = Paint()..color=Colors.redAccent..strokeWidth=width..strokeCap=StrokeCap.round..style=PaintingStyle.stroke;
    Paint hourPaint = Paint()..color=Colors.blueAccent..strokeWidth=width..strokeCap=StrokeCap.round..style=PaintingStyle.stroke;

    canvas.drawArc(new Rect.fromPoints(Offset(centerX-400, centerY-400), Offset(centerX+400, centerY+400)), -math.pi/2, math.pi*now.second/30, false, secondPaint);
    canvas.drawArc(new Rect.fromPoints(Offset(centerX-400+width+10, centerY-400+width+10), Offset(centerX+400-width-10, centerY+400-width-10)), -math.pi/2, math.pi*now.minute/30, false, minutePaint);
    canvas.drawArc(new Rect.fromPoints(Offset(centerX-400+2*(width+10), centerY-400+2*(width+10)), Offset(centerX+400-2*(width+10), centerY+400-2*(width+10))), -math.pi/2, math.pi*(now.hour%12)/6, false, hourPaint);


    canvas.drawLine(Offset(centerX, centerY), Offset(centerX+280*math.cos(math.pi*now.second/30-math.pi/2), centerY+280*math.sin(math.pi*now.second/30-math.pi/2)), secondPaint);
    canvas.drawLine(Offset(centerX, centerY), Offset(centerX+230*math.cos(math.pi*now.minute/30-math.pi/2), centerY+230*math.sin(math.pi*now.minute/30-math.pi/2)), minutePaint);
    canvas.drawLine(Offset(centerX, centerY), Offset(centerX+150*math.cos(math.pi*(now.hour%12)/6-math.pi/2), centerY+150*math.sin(math.pi*(now.hour%12)/6-math.pi/2)), hourPaint);

    canvas.drawCircle(Offset(centerX, centerY), width, new Paint()..color=Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}