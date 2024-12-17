import 'package:math_training/database/models/game_stats.dart';
import 'package:math_training/database/models/mental_training_stats.dart';
import 'package:math_training/database/models/speed_training_stats.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/database/stats_database.dart';
import 'package:math_training/database/stats_tables.dart';
import 'package:sqflite/sqflite.dart';

class StatsDAO {
  final StatsDatabase _dbProvider = StatsDatabase.instance();
  StatsDAO();

  Future<List<SpeedTrainingTime>> getSpeedTrainingTimes(
      SpeedTrainingType type) async {
    final db = await _dbProvider.database;
    var res = await db.query(
      SpeedTimesTable.tableName,
      where: "${SpeedTimesTable.type} = ?",
      whereArgs: [type],
    );

    List<SpeedTrainingTime> times = res.isNotEmpty
        ? res.map((row) => SpeedTrainingTime.fromDatabaseJson(row)).toList()
        : [];

    return times;
  }

  Future<List<SpeedTrainingTime>> getAllBestSpeedTrainingTimes() async {
    final db = await _dbProvider.database;
    var res = await db.rawQuery(
        'SELECT ${SpeedTimesTable.type}, MIN(${SpeedTimesTable.time}) as time FROM ${SpeedTimesTable.tableName} GROUP BY ${SpeedTimesTable.type};');

    List<SpeedTrainingTime> times = res.isNotEmpty
        ? res.map((row) => SpeedTrainingTime.fromDatabaseJson(row)).toList()
        : [];

    return times;
  }

  Future<SpeedTrainingTime?> getBestSpeedTrainingTime(
      SpeedTrainingType type) async {
    final db = await _dbProvider.database;
    var res = await db.rawQuery(
      'SELECT ${SpeedTimesTable.type}, MIN(${SpeedTimesTable.time}) as time FROM ${SpeedTimesTable.tableName} WHERE ${SpeedTimesTable.type} = ${type.index}',
    );

    List<SpeedTrainingTime> times = res.isNotEmpty
        ? res.map((row) => SpeedTrainingTime.fromDatabaseJson(row)).toList()
        : [];

    return times.isNotEmpty ? times[0] : null;
  }

  Future<List<GameTime>> getGameTimes(GameType type) async {
    final db = await _dbProvider.database;
    var res = await db.query(
      GamesTimesTable.tableName,
      where: "${GamesTimesTable.type} = ?",
      whereArgs: [type],
    );

    List<GameTime> times = res.isNotEmpty
        ? res.map((row) => GameTime.fromDatabaseJson(row)).toList()
        : [];

    return times;
  }

  Future<List<GameTime>> getAllBestGamesTimes() async {
    final db = await _dbProvider.database;
    var res = await db.rawQuery(
        'SELECT ${GamesTimesTable.type}, MIN(${GamesTimesTable.time}) as time FROM ${GamesTimesTable.tableName} GROUP BY ${GamesTimesTable.type};');

    List<GameTime> times = res.isNotEmpty
        ? res.map((row) => GameTime.fromDatabaseJson(row)).toList()
        : [];

    return times;
  }

  Future<GameTime?> getBestGameTime(GameType type) async {
    final db = await _dbProvider.database;
    var res = await db.rawQuery(
      'SELECT ${GamesTimesTable.type}, MIN(${GamesTimesTable.time}) as time FROM ${GamesTimesTable.tableName} WHERE ${GamesTimesTable.type} = ${type.index}',
    );

    List<GameTime> times = res.isNotEmpty
        ? res.map((row) => GameTime.fromDatabaseJson(row)).toList()
        : [];

    return times.isNotEmpty ? times[0] : null;
  }

  Future<MentalTrainingStats?> getMentalTrainingStats(
      MentalTrainingType type) async {
    final db = await _dbProvider.database;
    var res = await db.query(
      MentalStatsTable.tableName,
      where: "${MentalStatsTable.type} = ?",
      whereArgs: [type],
    );

    List<MentalTrainingStats> stats = res.isNotEmpty
        ? res.map((row) => MentalTrainingStats.fromDatabaseJson(row)).toList()
        : [];

    return stats.isNotEmpty ? stats[0] : null;
  }

  Future<List<MentalTrainingStats>> getAllMentalTrainingStats() async {
    final db = await _dbProvider.database;
    var res = await db.query(MentalStatsTable.tableName);

    List<MentalTrainingStats> stats = res.isNotEmpty
        ? res.map((row) => MentalTrainingStats.fromDatabaseJson(row)).toList()
        : [];

    return stats;
  }

  Future<bool> insertSpeedTrainingTime(SpeedTrainingTime speedTime) async {
    final db = await _dbProvider.database;
    final res = await db.insert(
      SpeedTimesTable.tableName,
      speedTime.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res != 0;
  }

  Future<bool> insertGameTime(GameTime speedTime) async {
    final db = await _dbProvider.database;
    final res = await db.insert(
      GamesTimesTable.tableName,
      speedTime.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res != 0;
  }

  Future<bool> increaseMentalTrainingCorrectAnswers(
      MentalTrainingType type) async {
    final db = await _dbProvider.database;

    final res = await db.rawInsert(
        '''INSERT INTO ${MentalStatsTable.tableName} (${MentalStatsTable.type}, ${MentalStatsTable.correctAnswers}) 
        VALUES (${type.index}, 1) ON CONFLICT(${MentalStatsTable.type}) 
        DO UPDATE SET ${MentalStatsTable.correctAnswers} = ${MentalStatsTable.correctAnswers} + 1;''');

    return res != 0;
  }
}
