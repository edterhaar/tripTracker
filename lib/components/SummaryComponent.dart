import 'package:flutter/material.dart';
import '../models/TripContainer.dart';
import '../Helpers.dart';

class SummaryComponent extends StatelessWidget {
  final TripContainer _tripContainer;

  SummaryComponent(this._tripContainer);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
      child: new Padding(
          padding: EdgeInsets.all(10.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Chip(
                  label: new Text(
                    "Average: " + Formatter.toTimeString(_tripContainer.getAverage()),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: averageColour,
                ),
                new Chip(
                    label: new Text(
                      "Best: " + Formatter.toTimeString(_tripContainer.getBest()?.time),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: bestColour),
                new Chip(
                    label: new Text(
                      "Worst: " + Formatter.toTimeString(_tripContainer.getWorst()?.time),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: worstColour)
              ])),
    );
  }
}
