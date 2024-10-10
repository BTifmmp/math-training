import 'package:math_training/database/models/mental_training_stats.dart';
import 'package:math_training/database/models/speed_training_stats.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/database/stats_database.dart';
import 'package:math_training/database/stats_tables.dart';

class SessionDAO {
  final StatsDatabase dbProvider;

  SessionDAO([StatsDatabase? dbProvider])
      : dbProvider = dbProvider ?? StatsDatabase.dbProvider;

  Future<List<SpeedTrainingTime>> getSpeedTrainingTimes(
      SpeedTrainingType type) async {
    final db = await dbProvider.database;
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

  Future<SpeedTrainingTime?> getBestSpeedTrainingTime(
      SpeedTrainingType type) async {
    final db = await dbProvider.database;
    var res = await db.rawQuery(
      'SELECT MIN(${SpeedTimesTable.time}) as best_time FROM ${SpeedTimesTable.tableName} WHERE ${SpeedTimesTable.type} = $type',
    );

    List<SpeedTrainingTime> times = res.isNotEmpty
        ? res.map((row) => SpeedTrainingTime.fromDatabaseJson(row)).toList()
        : [];

    return times.isNotEmpty ? times[0] : null;
  }

  Future<MentalTrainingStats?> getMentalTrainingStats(
      MentalTrainingType type) async {
    final db = await dbProvider.database;
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

  Future<bool> insertSpeedTrainingTime(SpeedTrainingType type, int time) async {
    return false;
  }

  // Future<SessionModel> getUser(int id) async {
  //   final db = await dbProvider.database;
  //   var res = await db.query(
  //     SessionsTable.SESSIONS_TABLE_NAME,
  //     where: "${SessionsTable.SESSIONS_ID} = ?",
  //     whereArgs: [id],
  //   );

  //   List<SessionModel>? sessionModel = res.isNotEmpty
  //       ? res.map((row) => SessionModel.fromDatabaseJson(row)).toList()
  //       : [];

  //   return sessionModel.isNotEmpty
  //       ? sessionModel[0]
  //       : const SessionModel.empty();
  // }

  // Future<bool> insertUser(SessionModel? localSessionModel) async {
  //   final db = await dbProvider.database;
  //   final result = await db.insert(
  //       SessionsTable.SESSIONS_TABLE_NAME, localSessionModel!.toDatabaseJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   return result != 0;
  // }

  // Future<bool> updateUser(int id, SessionModel localSessionModel) async {
  //   final db = await dbProvider.database;
  //   final result = await db.update(
  //     SessionsTable.SESSIONS_TABLE_NAME,
  //     localSessionModel.toDatabaseJson(),
  //     where: "${SessionsTable.SESSIONS_ID} = ?",
  //     whereArgs: [id],
  //   );
  //   return result != 0;
  // }

  // Future<bool> deleteUser(int id) async {
  //   final db = await dbProvider.database;
  //   final result = await db.delete(
  //     SessionsTable.SESSIONS_TABLE_NAME,
  //     where: "${SessionsTable.SESSIONS_ID} = ?",
  //     whereArgs: [id],
  //   );
  //   return result != 0;
  // }
}
