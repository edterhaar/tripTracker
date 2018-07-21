import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'TripDbModel.dart';
import 'TripsContainerDbModel.dart';
import '../models/TripContainer.dart';
import '../models/Trip.dart';

class TableNames {
  static final String tripContainer = "tripContainer";
  static final String trip = "trip";
}

class DatabaseClient {
  static final DatabaseClient _repo = new DatabaseClient._internal();

  static DatabaseClient get() {
    return _repo;
  }

  DatabaseClient._internal() ;

  Database _db;
  bool _didInit = false;

  Future _init() async {
    if (_didInit) {
      return;
    }

    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "trips.db");

    _db = await openDatabase(dbPath, version: 1, onCreate: this._create);
    _didInit = true;
  }

  Future<Database> _getDb() async {
    if (!_didInit) await _init();
    return _db;
  }

  Future close() async {
    var db = await _getDb();
    await db.close();
    _didInit = false;
  }

  Future saveTripContainer(TripContainer tripContainer) async {
    var tripContainerModel = new TripContainerDbModel.fromTrip(tripContainer);

    if (tripContainerModel.id == null) {
      tripContainer.id = await _insertTripContainer(tripContainerModel);
    } else {
      await _updateTripContainer(tripContainerModel);
    }
  }

  Future deleteTripContainer(TripContainer tripContainer) async {
    var tripContainerModel = new TripContainerDbModel.fromTrip(tripContainer);

    if (tripContainerModel.id == null) {
      // tripContainer.id = await _insertTripContainer(tripContainerModel);
    } else {
      await _deleteTripContainer(tripContainerModel);
    }
  }

  Future saveTrip(Trip trip, TripContainer tripContainer) async {
    TripDbModel tripModel = new TripDbModel.fromTrip(trip);
    tripModel.tripContainer_id = tripContainer.id;

    if (tripModel.id == null) {
      trip.id = await _insertTrip(tripModel);
    } else {
      await _updateTrip(tripModel);
    }
  }

  Future deleteTrip(Trip trip, TripContainer tripContainer) async {
    TripDbModel tripModel = new TripDbModel.fromTrip(trip);
    tripModel.tripContainer_id = tripContainer.id;

    if (tripModel.id == null) {
      //trip.id = await _insertTrip(tripModel);
    } else {
      await _deleteTrip(tripModel);
    }
  }

  Future<List<TripContainer>> getGetAllTripContainers() async {
    var tripContainerModels = await _fetchAllTripContainer();

    List<TripContainer> tripContainers = new List();

    for (var tripContainerModel in tripContainerModels) {
      TripContainer tripContainer =
          new TripContainer(tripContainerModel.name, tripContainerModel.id);
      List<TripDbModel> tripModels = await _fetchTripWithContinerId(tripContainerModel.id);

      for (var tripModel in tripModels) {
        tripContainer.trips.add(new Trip(new Duration(milliseconds: tripModel.time),
            DateTime.parse(tripModel.date), tripModel.id));
      }

      tripContainers.add(tripContainer);
    }

    return tripContainers;
  }

  Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE ${TableNames.tripContainer} (
              ${TripContainerFieldNames.id} INTEGER PRIMARY KEY,
              ${TripContainerFieldNames.name} TEXT NOT NULL
            )""");

    await db.execute("""
            CREATE TABLE ${TableNames.trip} (
              ${TripFieldNames.id} INTEGER PRIMARY KEY,
              ${TripFieldNames.date} TEXT NOT NULL,
              ${TripFieldNames.time} INTEGER NOT NULL,
              ${TripFieldNames.tripContainer_id} INTEGER NOT NULL,
              FOREIGN KEY (${TripFieldNames.tripContainer_id}) REFERENCES ${TableNames.tripContainer} (${TripContainerFieldNames.id}) 
                ON DELETE CASCADE ON UPDATE NO ACTION
            )""");
  }

//todo refactor out to one function
  Future<int> _insertTrip(TripDbModel trip) async {
    Database db = await _getDb();
    trip.id = await db.insert(TableNames.trip, trip.toMap());
    return trip.id;
  }

  Future<int> _deleteTrip(TripDbModel trip) async {
    Database db = await _getDb();
    trip.id =
        await db.delete(TableNames.trip, where: "${TripFieldNames.id} = ?", whereArgs: [trip.id]);
    return trip.id;
  }

  Future<TripDbModel> _updateTrip(TripDbModel trip) async {
    Database db = await _getDb();
    await db.update(TableNames.trip, trip.toMap(),
        where: "${TripFieldNames.id} = ?", whereArgs: [trip.id]);
    return trip;
  }

  Future<int> _insertTripContainer(TripContainerDbModel tripContainer) async {
    Database db = await _getDb();
    tripContainer.id = await db.insert(TableNames.tripContainer, tripContainer.toMap());

    return tripContainer.id;
  }

  Future<int> _deleteTripContainer(TripContainerDbModel tripContainer) async {
    Database db = await _getDb();
    tripContainer.id = await db.delete(TableNames.tripContainer,
        where: "${TripContainerFieldNames.id} = ?", whereArgs: [tripContainer.id]);
    return tripContainer.id;
  }

  Future<TripContainerDbModel> _updateTripContainer(TripContainerDbModel tripContainer) async {
    Database db = await _getDb();
    await db.update(TableNames.tripContainer, tripContainer.toMap(),
        where: "${TripContainerFieldNames.id} = ?", whereArgs: [tripContainer.id]);
    return tripContainer;
  }

  Future<List<TripDbModel>> _fetchTripWithContinerId(int id) async {
    Database db = await _getDb();
    List<Map> results = await db.query(TableNames.trip,
        columns: TripDbModel.columns,
        where: "${TripFieldNames.tripContainer_id} = ?",
        whereArgs: [id]);

    List<TripDbModel> tripModels = new List();
    for (var result in results) {
      TripDbModel tripDbModel = TripDbModel.fromMap(result);
      tripModels.add(tripDbModel);
    }

    return tripModels;
  }

  Future<List<TripContainerDbModel>> _fetchAllTripContainer() async {
    Database db = await _getDb();
    List<Map> results =
        await db.query(TableNames.tripContainer, columns: TripContainerDbModel.columns);

    List<TripContainerDbModel> tripContainerDbModels = new List();
    results.forEach((result) {
      TripContainerDbModel tripContainerDbModel = TripContainerDbModel.fromMap(result);
      tripContainerDbModels.add(tripContainerDbModel);
    });

    return tripContainerDbModels;
  }
}
