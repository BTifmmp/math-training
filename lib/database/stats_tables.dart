import 'package:sqflite/sqflite.dart';

class SpeedTimesTable {
  static const String tableName = "SpeedTimes";
  static const String type = "type";
  static const String time = "time";

  static void createTable(Database database) async {
    await database.execute('''
      CREATE TABLE $tableName (
        training_type INTEGER REFERENCES training(type),
        time BIGINT
      )
    ''');
  }
}

class MentalStatsTable {
  static const String tableName = "MentalStats";
  static const String type = "type";
  static const String correctAnswers = "correctAnswers";

  static void createTable(Database database) async {
    await database.execute('''
      CREATE TABLE $tableName (
        $type INTEGER PRIMARY KEY,
        $correctAnswers INTEGER,

      )
    ''');
  }
}
