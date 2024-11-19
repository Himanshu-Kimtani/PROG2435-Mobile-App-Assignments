import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'trips.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('trips.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE trips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT NOT NULL,
        destination TEXT NOT NULL,
        price REAL NOT NULL,
        additionalInfo TEXT,
        customerType INTEGER
      )
    ''');
  }

  Future<void> insertTrip(Trip trip) async {
    final db = await database;
    await db.insert('trips', trip.toMap());
  }

  Future<void> updateTrip(Trip trip) async {
    final db = await database;
    await db.update(
      'trips',
      trip.toMap(),
      where: 'id = ?',
      whereArgs: [trip.id],
    );
  }

  Future<List<Trip>> fetchTrips() async {
    final db = await database;
    final maps = await db.query('trips');

    return List.generate(maps.length, (i) {
      return Trip.fromMap(maps[i]);
    });
  }

  Future<void> deleteTrip(int id) async {
    final db = await database;
    await db.delete(
      'trips',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
