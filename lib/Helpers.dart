import 'package:intl/intl.dart';

String getTimeString(Duration duration) {
  if (duration == null) return "-:-";

  return duration.toString().split(".")[0];
}

String getDateString(DateTime date) {
  if (date == null) return "-:-";

  return new DateFormat.yMd('en-GB').format(date);
} 
