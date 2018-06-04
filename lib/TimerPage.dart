import 'package:flutter/material.dart';
import 'dart:async';
import 'models/Trip.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);
  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  DateTime startTime;
  Timer _timer;
  final String _title = "New trip";

  TimerPageState() {
    _timer = new Timer.periodic(new Duration(microseconds: 250), onTick);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_title),
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Text(
                TimerTextFormatter.format(differenceInTime().inMilliseconds),
                style: new TextStyle(fontSize: 60.0),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: new FloatingActionButton(
                  child: new Text(startTime == null ? "Start" : "Finish",
                      style: new TextStyle(fontSize: 16.0)),
                  onPressed: buttonPressed),
            ),
          ],
        ));
  }

  void buttonPressed() {
    setState(() {
      if (startTime == null) {
        startTime = new DateTime.now();
      } else {
        Navigator.of(context).pop(new Trip(differenceInTime(), new DateTime.now()));
      }
    });
  }

  void onTick(Timer t) {
    setState(() {});
  }

  Duration differenceInTime() {
    if (startTime == null) return new Duration(seconds: 0);

    return new DateTime.now().difference(startTime);
  }
}

class TimerTextFormatter {
  static String format(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}
