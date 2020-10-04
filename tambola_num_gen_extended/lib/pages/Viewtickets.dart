
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ViewTickets extends StatefulWidget{
//  final Map<String, dynamic> ticketsData;
  final List ticket;
  final List numbers;

  ViewTickets({Key key, this.ticket, this.numbers}) : super(key: key);


  @override
  _ViewTicketsState createState() => _ViewTicketsState(ticket, numbers);

}

class _ViewTicketsState extends State<ViewTickets> {

  final List ticket;
  final List numbers;
  String status;

  _ViewTicketsState(this.ticket, this.numbers);

  List<Widget> getBlock() {
    List<Widget> grids = [];
    ticket.forEach((element) {
      grids.add(Container(
          decoration: BoxDecoration(
              color: element == 0 ?Colors.white:( !numbers.contains(element)? Colors.blueGrey.shade800: Colors.blueGrey),
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
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ubuntu",
                  decoration: element == 0 ?TextDecoration.none: !numbers.contains(element)? TextDecoration.lineThrough: TextDecoration.none,
                decorationColor: Colors.black
              ),
            ),
          )));
    });
    return grids;
  }

  List getNumbersFromTicket(List ticket){
    List elements = [];
    ticket.forEach((element) { if(element!=0) elements.add(element); });

    return elements;
  }

  void check4Corner(List ticket){
    List elements = getNumbersFromTicket(ticket);
    if(!numbers.contains(elements[0]) && !numbers.contains(elements[4]) && !numbers.contains(elements[10]) && !numbers.contains(elements[14])){
//      print(elements[0]);print(elements[4]);print(elements[10]);print(elements[14]);
      status='4 Corners found';
    }
    else
      status='4 Corners not found';
    setState(() {});
  }


  void checkFirstRow(List ticket){
    List elements = getNumbersFromTicket(ticket);
    if(!numbers.contains(elements[0]) && !numbers.contains(elements[1]) && !numbers.contains(elements[2]) && !numbers.contains(elements[3]) && !numbers.contains(elements[4])){
      status='First row found';
    }
    else
      status='First row not found';
    setState(() {});
  }


  void checkSecondRow(List ticket){
    List elements = getNumbersFromTicket(ticket);
    if(!numbers.contains(elements[5]) && !numbers.contains(elements[6]) && !numbers.contains(elements[7]) && !numbers.contains(elements[8]) && !numbers.contains(elements[9])){
      status='Second row found';
    }
    else
      status='second row not found';
    setState(() {});
  }


  void checkThirdRow(List ticket){
    List elements = getNumbersFromTicket(ticket);
    if(!numbers.contains(elements[10]) && !numbers.contains(elements[11]) && !numbers.contains(elements[12]) && !numbers.contains(elements[13]) && !numbers.contains(elements[14])){
      status='Third row found';
    }
    else
      status='third row not found';
    setState(() {});
  }

  void checkPyramid(List ticket){
    List elements = getNumbersFromTicket(ticket);
    if(!numbers.contains(elements[2]) && !numbers.contains(elements[6]) && !numbers.contains(elements[8]) && !numbers.contains(elements[10]) && !numbers.contains(elements[12]) && !numbers.contains(elements[14])){
      status='Pyramid found';
    }
    else
      status='Pyramid not found';
    setState(() {});
  }

  void checkRevPyramid(List ticket){
    List elements = getNumbersFromTicket(ticket);
    if(!numbers.contains(elements[0]) && !numbers.contains(elements[2]) && !numbers.contains(elements[4]) && !numbers.contains(elements[6]) && !numbers.contains(elements[8]) && !numbers.contains(elements[12])){
      status='Rev Pyramid found';
    }
    else
      status='Rev Pyramid not found';
    setState(() {});
  }

  void checkFirst5(List ticket){
    List elements = getNumbersFromTicket(ticket);
    int count=0;
    elements.forEach((element) { if(!numbers.contains(element)) count++; });

    if(count==5){
      status='Early 5 found';
    }
    else
      status='Early 5 not found';
    setState(() {});
  }
  void checkFirst7(List ticket){
    List elements = getNumbersFromTicket(ticket);
    int count=0;
    elements.forEach((element) { if(!numbers.contains(element)) count++; });

    if(count==7){
      status='Early 7 found';
    }
    else
      status='Early 7 not found';
    setState(() {});
  }

  void checkFullHouse(List ticket){
    List elements = getNumbersFromTicket(ticket);
    int count=0;
    elements.forEach((element) { if(!numbers.contains(element)) count++; });

    if(count==15){
      status='Full house found';
    }
    else
      status='full house not found';
    setState(() {});
  }
  void checkDevrani(List ticket){
    int count=0;
    ticket.forEach((element) {
      if(element>=1 && element<=45)
        if(numbers.contains(element))
          count++;
    });

    if(count==0){
      status='Devrani found';
    }
    else
      status='Devrani not found';
    setState(() {});
  }
  void checkJethani(List ticket){
    int count=0;
    ticket.forEach((element) {
      if(element>=46 && element<=90)
        if(numbers.contains(element))
          count++;
    });

    if(count==0){
      status='Jethani found';
    }
    else
      status='Jethani not found';
    setState(() {});
  }
  void checkBreakFast(List ticket){
    int count=0;
    ticket.forEach((element) {
      if(element>=1 && element<=29)
        if(numbers.contains(element))
          count++;
    });

    if(count==0){
      status='breakfast found';
    }
    else
      status='breakfast not found';
    setState(() {});
  }
  void checkLunch(List ticket){
    int count=0;
    ticket.forEach((element) {
      if(element>=30 && element<=59)
        if(numbers.contains(element))
          count++;
    });

    if(count==0){
      status='Lunch found';
    }
    else
      status='Lunch not found';
    setState(() {});
  }
  void checkDinner(List ticket){
    int count=0;
    ticket.forEach((element) {
      if(element>=60 && element<=90)
        if(numbers.contains(element))
          count++;
    });

    if(count==0){
      status='Dinner found';
    }
    else
      status='Dinner not found';
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 100.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
                width: 700,
//            height: 500.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 9,
                      children: getBlock(),
                      shrinkWrap: true,
                      childAspectRatio: 1,
                    ),

                    SizedBox(
                      height: 500.0,
                    ),
                    Text(status==null? '': status,
                      style: TextStyle(
                          color: status!=null?(status.contains('not')?Colors.red:Colors.green):Colors.green,
                          fontSize: 65.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Ubuntu",
                          decoration: TextDecoration.none,
                      ),)
                  ],
                )
            ),
            SizedBox(width: 50.0,),
            Container(
              child: Column(
                children: [Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //************************************************* 4 corners ******************************
                  RaisedButton(
                    onPressed: () {
                      check4Corner(ticket);
                    },
                    child: Text(
                      '4 Corners',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Ubuntu"),
                    ),
                    color: Colors.redAccent,
                    padding: EdgeInsets.all(10.0),
                  ),

                  SizedBox(width: 50.0,),
                  // ************************************************** first row ***********************
                  RaisedButton(
                    onPressed: () {
                      checkFirstRow(ticket);
                    },
                    child: Text(
                      'First Row',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Ubuntu"),
                    ),
                    color: Colors.redAccent,
                    padding: EdgeInsets.all(10.0),
                  ),
                  SizedBox(width: 50.0,),
                  // *************************************************** second row ***************************
                  RaisedButton(
                    onPressed: () {
                      checkSecondRow(ticket);
                    },
                    child: Text(
                      'Second Row',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Ubuntu"),
                    ),
                    color: Colors.redAccent,
                    padding: EdgeInsets.all(10.0),
                  ),
                  SizedBox(width: 50.0,),
                  //******************************************************** third row *****************************
                  RaisedButton(
                    onPressed: () {
                      checkThirdRow(ticket);
                    },
                    child: Text(
                      'Third Row',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Ubuntu"),
                    ),
                    color: Colors.redAccent,
                    padding: EdgeInsets.all(10.0),
                  ),
                  SizedBox(width: 50.0,),
                  // ******************************************************* pyramid ******************************
                  RaisedButton(
                    onPressed: () {
                      checkPyramid(ticket);
                    },
                    child: Text(
                      'Pyramid',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Ubuntu"),
                    ),
                    color: Colors.redAccent,
                    padding: EdgeInsets.all(10.0),
                  ),
                ],
              ),

                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ******************************************************* rev pyramid ******************************
                      RaisedButton(
                        onPressed: () {
                          checkRevPyramid(ticket);
                        },
                        child: Text(
                          'Rev Pyramid',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(width: 50.0,),
                      // ******************************************************* first 7 ***************************
                      RaisedButton(
                        onPressed: () {
                          checkFirst7(ticket);
                        },
                        child: Text(
                          'First 7',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(width: 50.0,),
                      //********************************************************** first 5 ******************************
                      RaisedButton(
                        onPressed: () {
                          checkFirst5(ticket);
                        },
                        child: Text(
                          'First 5',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(width: 50.0,),
                      //********************************************************** Breakfast ******************************
                      RaisedButton(
                        onPressed: () {
                          checkBreakFast(ticket);
                        },
                        child: Text(
                          'breakfast',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ******************************************************* Lunch ******************************
                      RaisedButton(
                        onPressed: () {
                          checkLunch(ticket);
                        },
                        child: Text(
                          'Lunch',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(width: 50.0,),
                      // ******************************************************* Dinner ***************************
                      RaisedButton(
                        onPressed: () {
                          checkDinner(ticket);
                        },
                        child: Text(
                          'Dinner',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(width: 50.0,),
                      //********************************************************** Jethani ******************************
                      RaisedButton(
                        onPressed: () {
                          checkJethani(ticket);
                        },
                        child: Text(
                          'Jethani',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(width: 50.0,),
                      //********************************************************** Jethani ******************************
                      RaisedButton(
                        onPressed: () {
                          checkDevrani(ticket);
                        },
                        child: Text(
                          'Jethani',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                      SizedBox(width: 50.0,),
                      //********************************************************** full house ******************************
                      RaisedButton(
                        onPressed: () {
                          checkFullHouse(ticket);
                        },
                        child: Text(
                          'Full house',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontFamily: "Ubuntu"),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(10.0),
                      ),
                    ],
                  )
              ]
              )

            )
          ],
        )
    );
  }
}