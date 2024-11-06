import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'trips.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE trips(id INTEGER PRIMARY KEY, name TEXT, destination TEXT)',
        );
      },
    );
  }

  Future<void> insertTrip(Map<String, dynamic> trip) async {
    final db = await database;
    await db.insert('trips', trip);
  }

  Future<List<Map<String, dynamic>>> getTrips() async {
    final db = await database;
    return await db.query('trips');
  }
}
