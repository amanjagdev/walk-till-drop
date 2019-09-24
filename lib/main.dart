import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = 'Unknown';
  StreamSubscription<int> _subscription;

  double _numerox; 
  double _convert;
  double _kmx;
  double burnedx;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    setUpPedometer();
  }

  void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    // print(stepCountValue); 
    setState(() {
      _stepCountValue = "$stepCountValue";
      // print(_stepCountValue);
    });

    var dist = stepCountValue; 
    double y = (dist + .0); 

    setState(() {
      _numerox =
          y; 
    });

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_numerox);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); 
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx; 
      _calories = "$calories";
      //print(_calories);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    //print(_stepCountValue);
    getBurnedRun();
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Walk Till Drop'),
          backgroundColor: Colors.blue,
        ),
        body: new ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0),
              width: 250, 
              height: 250, 
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment
                  //       .bottomCenter, 
                  //   end: Alignment.topCenter,
                  //   colors: [Color(0xFFA9F5F2), Color(0xFF01DFD7)],
                  // ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(27.0),
                    bottomRight: Radius.circular(27.0),
                    topLeft: Radius.circular(27.0),
                    topRight: Radius.circular(27.0),
                  )),
              child: new CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 13.0,
                animation: true,
                center: Container(
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(
                          FontAwesomeIcons.walking,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        //color: Colors.orange,
                        child: Text(
                          '$_stepCountValue',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.blue),
                        ),
                        // height: 50.0,
                        // width: 50.0,
                      ),
                    ],
                  ),
                ),
                percent: 0.217,
                //percent: _convert,
                footer: new Text(
                  "Steps:  $_stepCountValue",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.blueAccent),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              padding: EdgeInsets.only(top: 2.0),
              width: 150, 
              height: 30,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(left: 40.0),
                    child: new Card(
                      child: Container(
                        child: Text(
                          "$_km Km",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),
                      color: Colors.black,
                    ),
                  ),
                  VerticalDivider(
                    width: 20.0,
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Card(
                      child: Container(
                        child: Text(
                          "$_calories kCal",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),
                      color: Colors.black,
                    ),
                  ),
                  VerticalDivider(
                    width: 5.0,
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: new Card(
                      child: Container(
                        child: Text(
                          "$_stepCountValue Steps",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
