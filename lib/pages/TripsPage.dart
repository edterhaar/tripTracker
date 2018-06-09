import 'package:flutter/material.dart';
import '../models/TripContainer.dart';
import '../models/Trip.dart';
import '../components/TripListItem.dart';
import '../Helpers.dart';
import 'TimerPage.dart';


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
      body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Card(
                margin: EdgeInsets.all(10.0),
                child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  new ListTile(
                      title: new Text(
                    "Average: " + getTimeString(widget.tripContainer.getAverage()),
                    textAlign: TextAlign.center,
                  )),
                  new ListTile(
                      title: new Text(
                    "Best: " + getTimeString(widget.tripContainer.getBest()?.time),
                    textAlign: TextAlign.center,
                  )),
                  new ListTile(
                      title: new Text(
                    "Worst: " + getTimeString(widget.tripContainer.getWorst()?.time),
                    textAlign: TextAlign.center,
                  )),
                ])),
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
          Trip trip = await Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new TimerPage(widget.tripContainer)));
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
