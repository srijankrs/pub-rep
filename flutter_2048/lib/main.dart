import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool selected = false;
  List grid = [];
  var _focusNode = FocusNode();
  var rng = new Random();
  List numbers = [2,4];


  @override
  void initState() {
    super.initState();
    for(int i=0;i<16;i++)
      grid.add(0);
    generateRandom();
    generateRandom();
  }


  void generateRandom(){
    int zero=0;
    grid.forEach((element) {
      if(element==0)
        zero++;
    });
    if(zero==0) return;

    int randomIndex = rng.nextInt(zero)+1;
    for(int i=0;i<grid.length;i++){
      if(grid[i]==0){
        randomIndex--;
      }
      if(randomIndex<=0) {
        if(grid[i]!=0){
          print("error $i $randomIndex");
        }
        grid[i] = numbers[rng.nextInt(2)];
        break;
      }
    }
  }


  List transform(List list){
    List finalList = [0,0,0,0];
    int index=0;
    list.forEach((item) {
      if(item != 0){
        if(finalList[index]==item){
          finalList[index]+=item;
          index++;
        }
        else if(finalList[index]!=item && finalList[index]!=0){
          index++;
          finalList[index]=item;
        }
        else{
          finalList[index]=item;
        }
      }
    });
    return finalList;
  }

  void onEvent(RawKeyEvent event) {
    if(event.logicalKey==LogicalKeyboardKey.arrowRight && event.runtimeType==RawKeyDownEvent){
      print(grid);
      List list = [];
      for(int i=grid.length-1;i>=0;) {
        list = [];
        int temp=i;
        for(int j = 1; j <= 4; j++,i--){
          list.add(grid[i]);
        }
        list=transform(list);
        i=temp;
        for (int j = 0; j < 4; j++,i--){
          grid[i] = list[j];
        }
      }
      generateRandom();
    }
    if(event.logicalKey==LogicalKeyboardKey.arrowLeft && event.runtimeType==RawKeyDownEvent){
      print(grid);
      List list = [];
      for(int i=0;i<=grid.length-1;) {
        list = [];
        int temp=i;
        for(int j = 1; j <= 4; j++,i++){
          list.add(grid[i]);
        }
        list=transform(list);
        i=temp;
        for (int j = 0; j < 4; j++,i++){
          grid[i] = list[j];
        }
      }
      generateRandom();
    }
    if(event.logicalKey==LogicalKeyboardKey.arrowDown && event.runtimeType==RawKeyDownEvent){
      print(grid);
      List list = [];
      for(int i=15;i>=12;i--) {
        list = [];
        for(int j = i; j >= 0; j-=4){
          list.add(grid[j]);
        }
        list=transform(list);
        int index=0;
        for(int j = i; j >= 0; j-=4){
          grid[j] = list[index];
          index++;
        }
      }
      generateRandom();
    }
    if(event.logicalKey==LogicalKeyboardKey.arrowUp && event.runtimeType==RawKeyDownEvent){
      print(grid);
      List list = [];
      for(int i=0;i<=3;i++) {
        list = [];
        for(int j = i; j <= 15; j+=4){
          list.add(grid[j]);
        }
        list=transform(list);
        int index=0;
        for(int j = i; j <= 15; j+=4){
          grid[j] = list[index];
          index++;
        }
      }
      generateRandom();
    }
    setState(() {});
  }

  List<Widget> getBlock(){
    List<Widget> grids = [];
    grid.forEach((element) {
      grids.add(
          GridTile(
              child: Container(
                  decoration: BoxDecoration(
                      color: element==0?Colors.black54:Colors.blueGrey
                  ),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Text(element==0?'':element.toString(), style: TextStyle(
                      color: element==0?Colors.black54:Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  ))));
    });
    return grids;
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
        body:RawKeyboardListener(
            focusNode: _focusNode,
            onKey: onEvent,
            child: Center(
                child : Container(
                  height: 400,
                  width: 400,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: getBlock(),),
                )
            )
        ));
  }
}
