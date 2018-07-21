import 'package:flutter/material.dart';
import '../models/TripContainer.dart';
import '../components/TripContainerListItem.dart';
import '../database/DatabaseClient.dart';
import 'NewTripContainerPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {
  List<TripContainer> _tripContainers = new List();

  _MyHomePageState();

  @override
  void initState() {
    super.initState();
    DatabaseClient.get().getGetAllTripContainers().then((t) {
      _tripContainers = t;
      setState(() {});
    });
  }

  @override
  void dispose() {
    print("Disposing");
    DatabaseClient.get().close();
    super.dispose();
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
          return new Dismissible(
              key: new Key(_tripContainers[index].title),
              onDismissed: (direction) async {
                TripContainer tripContainer = _tripContainers[index];
                _tripContainers.remove(tripContainer);
                await DatabaseClient.get().deleteTripContainer(tripContainer);
              },
              child: new Column(children: <Widget>[
                new TripsContainerListItem(_tripContainers[index]),
                new Divider(height: 5.0)
              ]));
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          var tripContainer = await Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new NewTripContainerPage()));
          if (tripContainer != null) {
            _tripContainers.add(tripContainer);
            await DatabaseClient.get().saveTripContainer(tripContainer);
          }
        },
        tooltip: 'New trip',
        child: new Icon(Icons.add),
      ),
    );
  }
}
