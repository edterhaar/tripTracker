import 'package:flutter/material.dart';
import 'models/TripContainer.dart';
import 'TripListItem.dart';
import 'models/Trip.dart';
import 'TimerPage.dart';
import 'TripsSummaryTop.dart';
import 'Helpers.dart';

class TripsPage extends StatefulWidget {
  final TripContainer tripContainer;
  TripsPage({Key key, this.tripContainer}) : super(key: key);

  @override
  TripsPageState createState() => new TripsPageState();
}

class TripsPageState extends State<TripsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.tripContainer.title),
        backgroundColor: Colors.greenAccent,
      ),
      body: new Column(children: <Widget>[
        new Expanded(
            flex: 1,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new TripSummaryTop(Colors.greenAccent[100], Icons.mood, getTripDetails(widget.tripContainer.getBest())),
                new TripSummaryTop(Colors.red[200], Icons.mood_bad, getTripDetails(widget.tripContainer.getWorst()))
              ],
            )),
        new Divider(
          height: 5.0,
        ),
        new Expanded(
            flex: 3,
            child: new ListView.builder(
              itemCount: widget.tripContainer.trips.length,
              itemBuilder: (context, index) {
                return new Column(children: <Widget>[
                  new TripsListItem(getTrip(index), getStatus(getTrip(index))),
                  new Divider(
                    height: 5.0,
                  )
                ]);
              },
            ))
      ]),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () async {
          Trip trip = await Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new TimerPage()));
          if (trip != null) {
            widget.tripContainer.trips.add(trip);
          }
        },
        tooltip: 'New trip',
        child: new Icon(Icons.add),
      ),
    );
  }

  String getTripDetails(Trip trip) =>
    "${getDateString(trip?.date)} \n ${getTimeString(trip?.time)}";

  Trip getTrip(int index) => widget.tripContainer.trips[index];

  BestWorst getStatus(Trip trip) {
    if (widget.tripContainer.getWorst() == trip)
      return BestWorst.Worst;
    else if (widget.tripContainer.getBest() == trip)
      return BestWorst.Best;
    else
      return BestWorst.Neither;
  }
}
