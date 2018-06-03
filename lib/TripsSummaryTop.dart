import 'package:flutter/material.dart';

class TripSummaryTop extends StatelessWidget {
  final Color _colour;
  final IconData _icon;
  final String _text;

  TripSummaryTop(this._colour, this._icon, this._text);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      new Container(
          decoration: new BoxDecoration(
        color: _colour,
      )),
      new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Icon(
            _icon,
            color: Colors.white,
            size: 50.0,
          ),
          new Text(
            _text,
            textAlign: TextAlign.center,
          )
        ],
      )
    ]));
  }
}
