import 'package:flutter/material.dart';
import '../models/Trip.dart';
import '../models/TripContainer.dart';
import '../Helpers.dart';

enum BestWorst { Best, Worst, Neither }

class TripsListItem extends StatelessWidget {
  final Trip _trip;
  final TripContainer _tripContainer;
  TripsListItem(this._trip, this._tripContainer);

  static const double _maxSize = 240.0;

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Theme.of(context).backgroundColor,
        child: new ListTile(
            title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Date: " + Formatter.toDateString(_trip.date)),
                new Text("Time: " + Formatter.toTimeString(_trip.time)),
              ],
            ),
            new Padding(padding: EdgeInsets.all(5.0)),
            new Stack(
              alignment: AlignmentDirectional.centerStart,
              children: <Widget>[
                getBarGraph(_trip, _tripContainer.getWorst(),
                    getColour(getStatus(_trip, _tripContainer), context)),
                new Container(
                    color: averageColour,
                    height: 60.0,
                    width: 3.0,
                    margin: EdgeInsets.only(
                        left: getSize(_tripContainer.getAverage(), _tripContainer.getWorst())))
              ],
            )
          ],
        )));
  }

  BestWorst getStatus(Trip trip, TripContainer tripContainer) {
    if (tripContainer.getWorst() == trip)
      return BestWorst.Worst;
    else if (tripContainer.getBest() == trip)
      return BestWorst.Best;
    else
      return BestWorst.Neither;
  }

  Container getBarGraph(Trip trip, Trip worstTrip, Color colour) {
    return new Container(color: colour, height: 40.0, width: getSize(trip.time, worstTrip));
  }

  Color getColour(BestWorst status, BuildContext context) {
    return status == BestWorst.Best
        ? bestColour
        : status == BestWorst.Worst
            ? worstColour
            : Theme.of(context).accentTextTheme.display1.color;
  }

  double getSize(Duration tripDuration, Trip worstTrip) {
    return tripDuration.inMilliseconds / worstTrip.time.inMilliseconds * _maxSize;
  }
}
