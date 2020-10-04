import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'dart:math';
import 'package:screenshot/screenshot.dart';

class GenerateTicket extends StatefulWidget {
  @override
  _GenerateTicketState createState() => _GenerateTicketState();
}

class _GenerateTicketState extends State<GenerateTicket> {
  Map<String, dynamic> players = Map();
  File jsonFile;
  Directory dir;
  String fileName = "/storage/emulated/0/tambola/players.json";
  bool fileExists = false;
  Map<String, String> fileContent;
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  bool isGenerating = false;
  List ticketElements = [];
  String ticketName;
  List<StreamData> streamList = [];
  Map<String, dynamic> ticketsData = Map();

  @override
  void initState() {
    super.initState();
    setPlayers();
  }

  void setPlayers() async {
    if(await Permission.storage.request().isGranted){
      jsonFile = new File(fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(() => players = jsonDecode(jsonFile.readAsStringSync()));
      else
        players["data"] = [];
      setState(() {});
    }
  }

  void savePlayers() {
    String serializedPlayers = jsonEncode(players);
    print("players " + serializedPlayers);
    File playersFile = File(fileName);
    if (playersFile.existsSync()) playersFile.deleteSync();
    playersFile.writeAsStringSync(serializedPlayers);
    setPlayers();
  }

  void _reset() {
    File playersFile = File(fileName);
    if (playersFile.existsSync()) playersFile.deleteSync();
    setPlayers();
  }

  void remove(int obj) {
    players["data"].removeAt(obj);
    savePlayers();
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void doGenerateAll() async {
    if (await Permission.storage.request().isGranted) {
      final String dirPath = '/storage/emulated/0/tambola/images';
      await Directory(dirPath).create(recursive: true);
      for (int i = 0; i < players["data"].length; i++) {
        print(players["data"][i]);
        for(int j=1;j<=players["data"][i]["count"];j++) {
          StreamData streamData = StreamData();
          streamData.count = j;
          streamData.name = players["data"][i]["name"];
          streamList.add(streamData);
        }
      }
      doGenerate();
    }
  }

  void doGenerate() {
    if(streamList.length>0) {
      int count = streamList[0].count;
      String name = streamList[0].name;
      print("count $count , name $name");
      ticketElements = getTicketArray();
      ticketName = name + " - $count";
      isGenerating = true;
      setState(() {});
      saveScreenshot();
      streamList.removeAt(0);
      ticketsData[ticketName] = ticketElements;
    }
    if(streamList.length==0){
      File ticketDataFile = new File("/storage/emulated/0/tambola/tickets.json");
      if(ticketDataFile.existsSync())
        ticketDataFile.deleteSync();
      ticketDataFile.writeAsStringSync(jsonEncode(ticketsData));
    }
  }

  List<Widget> getBlock() {
    List<Widget> grids = [];
    ticketElements.forEach((element) {
      grids.add(GridTile(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
              border: Border.all(
                color: Colors.black54,
                width: 1
              )),
              height: 100,
              width: 100,
              child: Center(
                child: Text(
                  element == 0 ? '' : element.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))));
    });
    return grids;
  }

  void saveScreenshot() {

      screenshotController
          .capture(path: "/storage/emulated/0/tambola/images/$ticketName.png")
          .then((File image) {
        print(image.path);
        setState(() {
          isGenerating = false;
        });
        doGenerate();
      }).catchError((onError) {
        print("error " + onError.toString());
        setState(() {
          isGenerating = false;
        });
      });
  }

//  Future<void> _capturePng() {
//    return new Future.delayed(const Duration(milliseconds: 20), () async {
//      RenderRepaintBoundary boundary =
//      globalKey.currentContext.findRenderObject();
//      ui.Image image = await boundary.toImage();
//      ByteData byteData =
//      await image.toByteData(format: ui.ImageByteFormat.png);
//      Uint8List pngBytes = byteData.buffer.asUint8List();
//      print(pngBytes);
//    });
//  }

  List getTicketArray() {
//    List list = [];
//    for (int i = 1; i <= 27; i++) list.add(i);
//    return list;

    var rnd = new Random();

    List positions = [];

    var items = new List<int>.generate(27, (int index) => 0);
//    print(items);

    var list1 = [0,1,2,3,4,5,6,7,8];
    var list2 = [9, 10, 11, 12, 13, 14, 15, 16, 17];
    var list3 = [18, 19, 20, 21, 22, 23, 24, 25, 26];
    list1.shuffle();
    list2.shuffle();
    list3.shuffle();

    positions.addAll(list1.sublist(0,5));
    positions.addAll(list2.sublist(0,5));
    positions.addAll(list3.sublist(0,5));

    positions.sort();

//    print(positions);

    var numList1 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    var numList2 = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
    var numList3 = [20, 21, 22, 23, 24, 25, 26, 27, 28, 29];
    var numList4 = [30, 31, 32, 33, 34, 35, 36, 37, 38, 39];
    var numList5 = [40, 41, 42, 43, 44, 45, 46, 47, 48, 49];
    var numList6 = [50, 51, 52, 53, 54, 55, 56, 57, 58, 59];
    var numList7 = [60, 61, 62, 63, 64, 65, 66, 67, 68, 69];
    var numList8 = [70, 71, 72, 73, 74, 75, 76, 77, 78, 79];
    var numList9 = [80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90];

    for(int i=0;i<items.length;i++){
      if(positions.contains(i)){
        if(i==0||i==9||i==18){
          int num = numList1[rnd.nextInt(numList1.length)];
          numList1.remove(num);
          items[i]=num;
        }
        else if(i==1||i==10||i==19){
          int num = numList2[rnd.nextInt(numList2.length)];
          numList2.remove(num);
          items[i]=num;
        }
        else if(i==2||i==11||i==20){
          int num = numList3[rnd.nextInt(numList3.length)];
          numList3.remove(num);
          items[i]=num;
        }
        else if(i==3||i==12||i==21){
          int num = numList4[rnd.nextInt(numList4.length)];
          numList4.remove(num);
          items[i]=num;
        }
        else if(i==4||i==13||i==22){
          int num = numList5[rnd.nextInt(numList5.length)];
          numList5.remove(num);
          items[i]=num;
        }
        else if(i==5||i==14||i==23){
          int num = numList6[rnd.nextInt(numList6.length)];
          numList6.remove(num);
          items[i]=num;
        }
        else if(i==6||i==15||i==24){
          int num = numList7[rnd.nextInt(numList7.length)];
          numList7.remove(num);
          items[i]=num;
        }
        else if(i==7||i==16||i==25){
          int num = numList8[rnd.nextInt(numList8.length)];
          numList8.remove(num);
          items[i]=num;
        }
        else if(i==8||i==17||i==26){
          int num = numList9[rnd.nextInt(numList9.length)];
          numList9.remove(num);
          items[i]=num;
        }
      }
    }

    for(int i=0;i<=8;i++){
      if(items[i]==0 && items[i+9] ==0 &&items[i+18] ==0){
//        print("calling again");
        return getTicketArray();
      }
      else{
        List temp = [];
        if(items[i] != 0)
          temp.add(items[i]);
        if(items[i+9] != 0)
          temp.add(items[i+9]);
        if(items[i+18] != 0)
          temp.add(items[i+18]);
        temp.sort();
        int t=0;
        if(items[i] != 0) {
          items[i] = temp[t];
          t++;
        }
        if(items[i+9] != 0) {
          items[i+9] = temp[t];
          t++;
        }
        if(items[i+18] != 0) {
          items[i+18] = temp[t];
        }
      }
    }

//    print(items);
    return items;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: [
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              onPressed: () {
                _reset();
              },
              child: Text(
                'Clear All',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontFamily: "Ubuntu"),
              ),
              color: Colors.redAccent,
              padding: EdgeInsets.all(10.0),
            ),
            RaisedButton(
              onPressed: () {
                doGenerateAll();
//                getTicketArray();
              },
              child: Text(
                'Generate All',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontFamily: "Ubuntu"),
              ),
              color: Colors.green,
              padding: EdgeInsets.all(10.0),
            ),
            RaisedButton(
              onPressed: () {
                nameController.clear();
                countController.clear();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: 260.0,
//                      color: Colors.red,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: TextField(
                                  controller: countController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'count',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ButtonTheme(
                                minWidth: 40.0,
                                height: 20.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    Map<String, dynamic> map = Map();
                                    map["name"] = nameController.text;
                                    map["count"] =
                                        int.parse(countController.text);
                                    players["data"].add(map);
                                    savePlayers();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100,
                                        fontFamily: "Ubuntu"),
                                  ),
                                  color: Colors.redAccent,
                                  padding: EdgeInsets.all(10.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Text(
                'Add new',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontFamily: "Ubuntu"),
              ),
              color: Colors.blue,
              padding: EdgeInsets.all(10.0),
            )
          ],
        ),
        isGenerating
            ? Screenshot(
                controller: screenshotController,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 170,
                        child: GridView.count(
                          crossAxisCount: 9,
                          children: getBlock(),
                        ),
                      ),
                      Container(
                        child: Text(ticketName,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),),
                      )
                    ],
                  )
                ),
              )
            : Container(
                height: 400,
                child: ListView.builder(
                    itemCount: players==null || players["data"]==null? 0:players["data"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Tile(
                        map: players["data"][index],
                        method: remove,
                        inc: index,
                      );
                    }),
              )
      ])),
    );
  }
}

class Tile extends StatelessWidget {
  final Map<String, dynamic> map;
  final int inc;
  final Function method;
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();

  Tile({Key key, this.map, this.method, this.inc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
//      color: Colors.green,
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              SizedBox(width: 150.0, child: Text(map["name"])),
              SizedBox(
                width: 20,
              ),
              SizedBox(width: 80.0, child: Text(map["count"].toString())),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onPressed: () => method(inc))
            ],
          ),
        ));
  }
}

class StreamData{
  int count;
  String name;
}