import 'package:flutter/material.dart';
import 'models/TripContainer.dart';
import 'TripContainerListItem.dart';
import 'NewTripContainerPage.dart';
import 'database/DatabaseClient.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<TripContainer> _tripContainers = new List();
  DatabaseClient db;

  _MyHomePageState() {
    db = new DatabaseClient();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    db.create().then((dynamic) => db.getGetAllTripContainers().then((t) {
          _tripContainers = t;
          setState(() {});
        }));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("Dipsoing");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.suspending || state == AppLifecycleState.inactive) {
      db.save(_tripContainers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
        itemCount: _tripContainers.length,
        itemBuilder: (context, index) {
          return new Column(children: <Widget>[
            new TripsContainerListItem(_tripContainers[index]),
            new Divider(
              height: 5.0,
            )
          ]);
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          var tripContainer = await Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new NewTripContainerPage()));
          if (tripContainer != null) {
            _tripContainers.add(tripContainer);
          }
        },
        tooltip: 'New trip',
        child: new Icon(Icons.add),
      ),
    );
  }
}
