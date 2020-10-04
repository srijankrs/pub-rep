import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tambola_num_gen/pages/GenerateTicket.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Viewtickets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var number = -1;
  var numbers = new List();
//  var staticNumbers;
  SharedPreferences prefs;
  Map<String, dynamic> ticketsData = Map();

  @override
  void initState() {
    super.initState();
    getData().then((value) {
    String temp = prefs.getString('data');
    print(temp);
    if(temp == null || temp.length==0) {
      numbers = new List();
      var i = 0;
      while (++i <= 90) {
        numbers.add(i);
      }
    }
    else{
      numbers = jsonDecode(temp)['numbers'];
      number=prefs.getInt('number');
      setState(() {});
    }
//    print(numbers.toString());
//    staticNumbers = numbers;
    });
  }

  Future<void> getData() async{
    prefs = await SharedPreferences.getInstance();
  }

  generateNumber() {
    var rng = new Random();
    setState(() {
      if (numbers.length == 0) return;
      if (numbers.length == 1) {
        number = numbers[0];
        numbers.removeAt(0);
      } else {
        var ran = rng.nextInt(numbers.length - 1);
        print("Index got : " + ran.toString());
        number = numbers[ran];
        numbers.removeAt(ran);
        print("Number removed : " + number.toString());
      }
    });
    Map<String, dynamic> map = Map();
    map["numbers"] = numbers;
    prefs.setString('data', jsonEncode(map));
    prefs.setInt('number', number);

    print(prefs.getString("data"));
  }

  resetNumber() {
    setState(() {
      number=-1;
      numbers=[];
      var i = 0;
      while (++i <= 90) {
        numbers.add(i);
      }
    });

    Map<String, dynamic> map = Map();
    map["numbers"] = numbers;
    prefs.setString('data', jsonEncode(map));
    prefs.setInt('number', number);
    print(prefs.getString("data"));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget _buildGridItems1(BuildContext context, int index) {
      return ListTile(
        index: index,
        numbers: numbers,
        size: width > height ? width : height,
      );
    }

    Widget _buildGridItems2(BuildContext context, int index) {
      index += 45;
      return ListTile(
        index: index,
        numbers: numbers,
        size: width > height ? width : height,
      );
    }

    Widget _row() {
      return Row(
        children: <Widget>[
          WebLeftCount(_buildGridItems1, width),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GeneratedNumber(number, width > height ? width : height),
                    SizedBox(
                      height: (width > height ? width : height) / 30,
                    ),
                    GenerateButton(generateNumber,
                        width > height ? width : height),
                    SizedBox(
                      height: (width > height ? width : height) / 40,
                    ),
                    ResetButton(resetNumber,
                        width > height ? width : height),
                    SizedBox(
                      height: (width > height ? width : height) / 50,
                    ),
                    Status(
                      numbers: numbers,
                      number: number,
                      size: width > height ? width : height,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateTicket()));
                      },
                      child: Text(
                        'Generate Tickets',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontFamily: "Ubuntu"),
                      ),
                      color: Colors.redAccent,
                      padding: EdgeInsets.all(10.0),
                    ),
                    ButtonTheme(
                      padding: EdgeInsets.all(1.0),
                      child: RaisedButton(
                        onPressed: () async {
                          String tickets = await DefaultAssetBundle.of(context).loadString('assets/tickets.json');
                          print(tickets);
                          ticketsData = jsonDecode(tickets);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                            CheckTickets(ticketsData:ticketsData, numbers: numbers,),
                          );
                        },
                        child: Text(
                          'Verify Tickets',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.greenAccent,
                      ),
                    )
                  ])),
          WebRightCount(_buildGridItems2, width),
        ],
      );
    }

    Widget _column() {
      return Column(
        children: <Widget>[
          SizedBox(
            height: (width > height ? width : height) / 60,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GeneratedNumber(number, width > height ? width : height),
//                    SizedBox(
//                      height: (width > height ? width : height) / 40,
//                    ),
//                    ResetButton(resetNumber,
//                        width > height ? width : height),
                    SizedBox(
                      height: (width > height ? width : height) / 40,
                    ),
                    GenerateButton(generateNumber,
                        width > height ? width : height),
                    SizedBox(
                      height: (width > height ? width : height) / 60,
                    ),
                    Status(
                      numbers: numbers,
                      number: number,
                      size: width > height ? width : height,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonTheme(
                          minWidth: 20,
                          height: 15,
                          padding: EdgeInsets.all(1.0),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateTicket()));
                            },
                            child: Text(
                              'Generate Tickets',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: "Ubuntu"),
                            ),
                            color: Colors.redAccent,
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 20,
                          height: 15,
                          padding: EdgeInsets.all(1.0),
                          child: RaisedButton(
                            onPressed: () {
                            },
                            child: Text(
                              'Verify Tickets',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: "Ubuntu"),
                            ),
                            color: Colors.greenAccent,
                          ),
                        )
                      ],
                    )
                  ])),
          MobileFullCount(_buildGridItems1, width, height)
        ],
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
                color: Colors.white,
                child: ScreenTypeLayout(
                  desktop: width > height && width > 740 ? _row() : _column(),
                  mobile: width > height ? _row() : _column(),
                  tablet: width > height ? _row() : _column(),
                ),
          ),
        ));
  }
}

class ListTile extends StatelessWidget {
  final index;
  final numbers;
  final size;

  ListTile({@required this.index, @required this.numbers, @required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GridTile(
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.black, width: 0.5),
              shape: BoxShape.circle,
              color: numbers.contains(index + 1)
                  ? Colors.white
                  : Colors.red //staticNumbers.contains((index+1).toString())
              ),
          child: Center(
            child: Container(
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                    color: numbers.contains(index + 1)
                        ? Colors.black87
                        : Colors.white,
                    fontSize: size / 55,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Ubuntu"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Status extends StatelessWidget {
  final numbers;
  final number;
  final size;

  @override
  Status({@required this.number, @required this.numbers, this.size});

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          numbers.length == 0
              ? "Full House"
              : number == -1
                  ? "Let the show begin"
                  : "",
          style: TextStyle(
              fontSize: size / 40,
              color: numbers.length == 0
                  ? Colors.red
                  : number == -1
                      ? Colors.green
                      : Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Ubuntu"),
        ),
      ),
    );
  }
}

class GenerateButton extends StatelessWidget {
  final Function generateNumber;
  final size;

  GenerateButton(this.generateNumber, this.size);

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        generateNumber();
      },
      child: Text(
        'Generate',
        style: TextStyle(
            fontSize: size / 40,
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontFamily: "Ubuntu"),
      ),
      color: Colors.blueAccent,
      padding: EdgeInsets.all(10.0),
    );
  }
}

class ResetButton extends StatelessWidget {
  final Function resetNumber;
  final size;

  ResetButton(this.resetNumber, this.size);

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        resetNumber();
      },
      child: Text(
        'Reset',
        style: TextStyle(
            fontSize: size / 100,
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontFamily: "Ubuntu"),
      ),
      color: Colors.brown,
      padding: EdgeInsets.all(10.0),
    );
  }
}

class GeneratedNumber extends StatelessWidget {
  final number;
  final size;

  GeneratedNumber(this.number, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size / 5,
      height: size / 5,
      child: Stack(
        children: <Widget>[
          Container(
            width: size / 5,
            height: size / 5,
            decoration: new BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
          ),
          Center(
            child: Text(
              number == -1 ? "!!" : number.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: size / 10),
            ),
          )
        ],
      ),
    );
  }
}

class WebRightCount extends StatelessWidget {
  final Function _buildGridItems;
  final width;

  WebRightCount(this._buildGridItems, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width * 2 / 5) - 24,
      height: width * 2 / 5,
      color: Colors.white,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, mainAxisSpacing: 25),
        itemBuilder: _buildGridItems,
        itemCount: 45,
        shrinkWrap: true,
      ),
      alignment: Alignment.center,
    );
  }
}

class WebLeftCount extends StatelessWidget {
  final Function _buildGridItems;
  final width;

  WebLeftCount(this._buildGridItems, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width * 2 / 5) - 24,
      height: width * 2 / 5,
      color: Colors.white,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, mainAxisSpacing: 25),
        itemBuilder: _buildGridItems,
        itemCount: 45,
        shrinkWrap: true,
      ),
      alignment: Alignment.center,
    );
  }
}

class MobileFullCount extends StatelessWidget {
  final Function _buildGridItems;
  final width;
  final height;

  MobileFullCount(this._buildGridItems, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width) - 24,
      height: height * 3 / 5 -33 ,
      color: Colors.white,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, mainAxisSpacing: 25),
        itemBuilder: _buildGridItems,
        itemCount: 90,
        shrinkWrap: true,
      ),
      alignment: Alignment.center,
    );
  }
}


class CheckTickets extends StatelessWidget{
  final Map<String, dynamic> ticketsData;
  final List numbers;

  CheckTickets({Key key, this.ticketsData, this.numbers}) : super(key: key);


  List<Widget> getBlock(BuildContext context) {
    List<Widget> grids = [];
    ticketsData.forEach((key, value) {
      grids.add(GestureDetector(
        child: GridTile(
            child: Container(
                margin: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.orangeAccent,
                      width: 2,

                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),

                height: 30,
                width: 60,
                child: Center(
                  child: Text(
                    key,
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Ubuntu",
                        decoration: TextDecoration.none
                    ),
                  ),
                ))),
        onTap: (){
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                ViewTickets(ticket: value,numbers: numbers,),
          );
        },
      )
      );
    });
    return grids;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(100.0),
      child: GridView.count(
      crossAxisCount: 8,
      children: getBlock(context),
    ),
    );
  }

}
