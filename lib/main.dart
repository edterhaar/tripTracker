import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'HomePage.dart';

void main() {
  initializeDateFormatting("en_GB", null).then((_) => runApp(new MyApp()));
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Current trips'),
    );
  }
}


