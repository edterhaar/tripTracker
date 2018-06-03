import '../models/TripContainer.dart';
class TripContainerFieldNames{
  static final String id = "id";
  static final String name = "name";
}

class TripContainerDbModel {
  int id;
  String name;

    TripContainerDbModel();
    TripContainerDbModel.fromTrip(TripContainer t)
  {
    this.id = t.id;
    this.name = t.title;
  }

  static final columns = [
    TripContainerFieldNames.id, 
    TripContainerFieldNames.name];

  Map<String,dynamic> toMap() {
    Map<String,dynamic> map = {
      TripContainerFieldNames.id: id,
      TripContainerFieldNames.name: name,
    };

    return map;
  }

  static fromMap(Map map) {
    TripContainerDbModel tripContainerDbModel = new TripContainerDbModel();
    tripContainerDbModel.id = map[TripContainerFieldNames.id];
    tripContainerDbModel.name = map[TripContainerFieldNames.name];

    return tripContainerDbModel;
  }
}