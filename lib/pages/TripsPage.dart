import 'package:flutter/material.dart';
import '../database/DatabaseClient.dart';
import '../models/TripContainer.dart';
import '../models/Trip.dart';
import '../components/TripListItem.dart';
import '../components/SummaryComponent.dart';
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
      appBar: new AppBar(title: new Text(widget.tripContainer.title)),
      body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new SummaryComponent(widget.tripContainer),
            new Divider(
              height: 5.0,
            ),
            new Expanded(
                flex: 3,
                child: new ListView.builder(
                  itemCount: widget.tripContainer.trips.length,
                  itemBuilder: (context, int index) {
                    return new Dismissible(
                      key: new Key(getTrip(index).id.toString()),
                      onDismissed: (direction) async {
                        Trip trip = getTrip(index);
                        await DatabaseClient.get().deleteTrip(trip, widget.tripContainer);
                        widget.tripContainer.trips.remove(trip);
                        setState(() {});
                      },
                      child: new Column(children: <Widget>[
                        new TripsListItem(getTrip(index),
                            widget.tripContainer),
                        new Divider(height: 5.0)
                      ]),
                    );
                  },
                ))
          ]),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          Trip trip = await Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new TimerPage(widget.tripContainer)));
          if (trip != null) {
            widget.tripContainer.trips.add(trip);
            await DatabaseClient.get().saveTrip(trip, widget.tripContainer);
          }
        },
        tooltip: 'New trip',
        child: new Icon(Icons.add),
      ),
    );
  }

  String getTripDetails(Trip trip) =>
      "${Formatter.toDateString(trip?.date)} \n ${Formatter.toTimeString(trip?.time)}";

  Trip getTrip(int index) => widget.tripContainer.trips[index];

  
}
