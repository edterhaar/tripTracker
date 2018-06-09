import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

Color worstColour = Colors.red[200];
Color bestColour = Colors.greenAccent[100];

class Formatter {
  static String toTimeString(Duration duration) {
    if (duration == null) return "-:-";

    return duration.toString().split(".")[0];
  }

  static String toDateString(DateTime date) {
    if (date == null) return "-:-";

    return new DateFormat.yMd('en-GB').format(date);
  }
}
