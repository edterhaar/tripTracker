import '../models/Trip.dart';

class TripFieldNames {
  static final String id = "id";
  static final String date = "date";
  static final String time = "time";
  static final String tripContainer_id = "tripContainer_id";
}

class TripDbModel {
  int id;
  String date;
  int time;
  int tripContainer_id;

  TripDbModel();
  TripDbModel.fromTrip(Trip t) {
    this.id = t.id;
    this.date = t.date.toString();
    this.time = t.time.inMilliseconds;
  }

  static final columns = [
    TripFieldNames.id,
    TripFieldNames.date,
    TripFieldNames.time,
    TripFieldNames.tripContainer_id
  ];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      TripFieldNames.id: id,
      TripFieldNames.date: date,
      TripFieldNames.time: time,
      TripFieldNames.tripContainer_id: tripContainer_id
    };

    return map;
  }

  static fromMap(Map map) {
    TripDbModel tripDbModel = new TripDbModel();
    tripDbModel.id = map[TripFieldNames.id];
    tripDbModel.date = map[TripFieldNames.date];
    tripDbModel.time = map[TripFieldNames.time];
    tripDbModel.tripContainer_id = map[TripFieldNames.tripContainer_id];

    return tripDbModel;
  }
}
