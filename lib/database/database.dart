import 'package:math_training/utils/database/stats_tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StatsDatabase {
  static final StatsDatabase dbProvider = StatsDatabase();

  static const databseName = "stats_database.db";

  Database? _database;

  Future<Database> get database async {
    _database ??= await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    //"ReactiveTodo.db is our database instance name
    String path = join(await getDatabasesPath(), databseName);

    var database = await openDatabase(path, onCreate: _initDB);
    return database;
  }

  void _initDB(Database database, int version) async {
    SpeedTimesTable.createTable(database);
    MentalStatsTable.createTable(database);
  }
}
