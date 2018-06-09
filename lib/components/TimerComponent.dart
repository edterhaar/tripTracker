import 'package:flutter/material.dart';
import 'ProgressPainter.dart';

class TimerComponent extends StatefulWidget {
  final Text time;
  final bool started;
  final Duration expectedTimeInternal;

  TimerComponent(
      {Key key, @required this.time, @required this.started, @required Duration expectedTime})
      : expectedTimeInternal = expectedTime == new Duration(milliseconds: 0)
            ? new Duration(minutes: 30)
            : expectedTime,
        super(key: key);

  TimerComponentState createState() => new TimerComponentState();
}

class TimerComponentState extends State<TimerComponent> with TickerProviderStateMixin {
  AnimationController _controller;
  TimerComponentState();
  DateTime timeStarted;

  Color _foreColour = Colors.blue;
  Color _backColour = Colors.greenAccent;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: widget.expectedTimeInternal,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (timeStarted != null &&
            new DateTime.now().difference(timeStarted) < widget.expectedTimeInternal) {
          _foreColour = Colors.greenAccent;
          _backColour = Colors.blue;
        }
        if (timeStarted != null &&
            new DateTime.now().difference(timeStarted) > widget.expectedTimeInternal) {
          if (_foreColour == Colors.red) {
            _backColour = Colors.red;
          } else {
            _foreColour = Colors.red;
            _backColour = Colors.greenAccent;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TimerComponent oldWidget) {
    if (widget.started && !_controller.isAnimating) {
      if (timeStarted == null) timeStarted = new DateTime.now();

      _controller.reverse(from: 1.0);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
        aspectRatio: 1.0,
        child: new Stack(children: <Widget>[
          new Positioned.fill(
              child: new Padding(
                  padding: EdgeInsets.all(40.0),
                  child: new AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) {
                        return new CustomPaint(
                            painter: new ProgressPainter(
                                animation: _controller,
                                color: _foreColour,
                                backgroundColor: _backColour));
                      }))),
          new Center(
            child: widget.time,
          )
        ]));
  }
}
