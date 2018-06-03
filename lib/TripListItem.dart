import 'package:flutter/material.dart';
import 'models/Trip.dart';
import 'Helpers.dart';

enum BestWorst { Best, Worst, Neither }

class TripsListItem extends StatelessWidget {
  final Trip _trip;
  final BestWorst _tripStatus;
  TripsListItem(this._trip, this._tripStatus);

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: _tripStatus == BestWorst.Worst
            ? Colors.red[200]
            : _tripStatus == BestWorst.Best ? Colors.greenAccent[100] : Colors.white,
        child: new ListTile(
            title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text("Date: " + getDateString(_trip.date)),
            new Text("Time: " + getTimeString(_trip.time))
          ],
        )));
  }
}
