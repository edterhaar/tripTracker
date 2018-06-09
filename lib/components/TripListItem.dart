import 'package:flutter/material.dart';
import '../models/Trip.dart';
import '../Helpers.dart';

enum BestWorst { Best, Worst, Neither }

class TripsListItem extends StatelessWidget {
  final Trip _trip;
  final BestWorst _tripStatus;
  TripsListItem(this._trip, this._tripStatus);

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: _tripStatus == BestWorst.Worst
            ? worstColour
            : _tripStatus == BestWorst.Best ? bestColour : Colors.white,
        child: new ListTile(
            title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text("Date: " + Formatter.toDateString(_trip.date)),
            new Text("Time: " + Formatter.toTimeString(_trip.time))
          ],
        )));
  }
}
