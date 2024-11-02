import 'package:math_training/database/stats_tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StatsDatabase {
  static final StatsDatabase _dbProvider = StatsDatabase._privateConstrcutor();
  StatsDatabase._privateConstrcutor();
  factory StatsDatabase.instance() => _dbProvider;

  static const databaseName = "stats_database.db";

  Database? _database;

  Future<Database> get database async {
    _database ??= await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    //"ReactiveTodo.db is our database instance name
    String path = join(await getDatabasesPath(), databaseName);

    var database = await openDatabase(path, version: 1, onCreate: _initDB);
    return database;
  }

  void _initDB(Database database, int version) async {
    SpeedTimesTable.createTable(database);
    GamesTimesTable.createTable(database);
    MentalStatsTable.createTable(database);
  }
}
