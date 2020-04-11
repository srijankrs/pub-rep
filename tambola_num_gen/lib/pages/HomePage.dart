import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var number = -1;
  var numbers = new List();
  var staticNumbers;

  @override
  void initState() {
    super.initState();
    var i = 0;
    while (++i <= 90) {
      numbers.add(i);
    }
    print(numbers.toString());
    staticNumbers = numbers;
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
                    GenerateButton(
                        generateNumber, width > height ? width : height),
                    SizedBox(
                      height: (width > height ? width : height) / 50,
                    ),
                    Status(
                      numbers: numbers,
                      number: number,
                      size: width > height ? width : height,
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
            height: (width > height ? width : height) / 50,
          ),
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
                    GenerateButton(
                        generateNumber, width > height ? width : height),
                    SizedBox(
                      height: (width > height ? width : height) / 50,
                    ),
                    Status(
                      numbers: numbers,
                      number: number,
                      size: width > height ? width : height,
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
              )),
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
              : number == -1 ? "Let the show begin" : "",
          style: TextStyle(
              fontSize: size / 40,
              color: numbers.length == 0
                  ? Colors.red
                  : number == -1 ? Colors.green : Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
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
      height: height * 3 / 5,
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