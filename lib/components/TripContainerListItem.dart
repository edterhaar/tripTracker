import 'package:flutter/material.dart';
import '../models/TripContainer.dart';
import '../pages/TripsPage.dart';
import '../Helpers.dart';

class TripsContainerListItem extends StatelessWidget {
  final TripContainer _tripContainer;

  TripsContainerListItem(this._tripContainer);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: new CircleAvatar(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Theme.of(context).primaryTextTheme.body1.color,
            child: new Text(_tripContainer.title[0])),
        title: new Text(_tripContainer.title),
        subtitle: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text("Best: " + Formatter.toTimeString(_tripContainer.getBest()?.time)),
            new Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
            new Text("Worst: " + Formatter.toTimeString(_tripContainer.getWorst()?.time))
          ],
        ),
        trailing: new Icon(
          Icons.keyboard_arrow_right,
          size: 50.0,
        ),
        onTap: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new TripsPage(tripContainer: _tripContainer))));
  }
}
