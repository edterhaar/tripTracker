import 'package:flutter/material.dart';
import 'models/TripContainer.dart';

class NewTripContainerPage extends StatefulWidget {
  NewTripContainerPage({Key key}) : super(key: key);

  @override
  NewTripContainerPageState createState() => new NewTripContainerPageState();
}

class NewTripContainerPageState extends State<NewTripContainerPage> {
  final String _title = "Create new trip";
  String _from;
  String _to;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void submit(BuildContext context) {
    
      final form = _formKey.currentState;

      if (form.validate()) {
        form.save();
        Navigator.of(context).pop(new TripContainer(_from, _to));
      }    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_title),
        ),
        body: new Form(
          key: this._formKey,
          child: new ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: <Widget>[
                new ListTile(
                    title: new TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Cannot be empty' : null,
                        decoration: new InputDecoration(
                          labelText: 'From',
                        ),
                        onSaved: (val) => _from = val)),
                new Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
                new ListTile(
                  title: new TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Cannot be empty' : null,
                      decoration: new InputDecoration(
                        labelText: 'To',
                      ),
                      onSaved: (val) => _to = val),
                ),
                new Container(
                    padding: const EdgeInsets.all(20.0),
                    child: new RaisedButton(
                      child: new Text(
                        'Create',
                        style: new TextStyle(color: Colors.white),
                      ),
                      onPressed:() => this.submit(context),
                      color: Colors.blue,
                    )),
              ]),
        ));
  }
}
