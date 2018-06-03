import 'Trip.dart';

class TripContainer {
  String title;
  final String _from;
  final String _to;
  final List<Trip> trips = new List();

  TripContainer(this._from, this._to) {
    title = _from + " - " + _to;
  }

  Trip getBest() {
    if (trips == null || trips.isEmpty) return null;
    return trips.reduce(getQuickest);
  }

  Trip getWorst() {
    if (trips == null || trips.isEmpty) return null;
    return trips.reduce(getLongest);
  }

  Trip getQuickest(Trip toCompareWith, Trip current) {
    if (toCompareWith == null) return current;

    return current.time < toCompareWith.time ? current : toCompareWith;
  }

  Trip getLongest(Trip toCompareWith, Trip current) {
    if (toCompareWith == null) return current;

    return current.time > toCompareWith.time ? current : toCompareWith;
  }
}
