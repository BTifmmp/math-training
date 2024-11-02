import 'package:flutter/foundation.dart';
import 'package:math_training/database/models/game_stats.dart';
import 'package:math_training/database/models/mental_training_stats.dart';
import 'package:math_training/database/models/speed_training_stats.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/database/stats_dao.dart';

class StatisticRepository {
  final _statsDao = StatsDAO();
  final speedTimesChanged = ChangeNotifier();
  final mentalStatsChanged = ChangeNotifier();
  final gamesTimesChanged = ChangeNotifier();

  StatisticRepository();

  Future<int?> getBestSpeedTrainingTime(SpeedTrainingType type) async {
    final res = await _statsDao.getBestSpeedTrainingTime(type);

    return res?.time;
  }

  Future<Map<SpeedTrainingType, int>> getAllBestSpeedTrainingTimes() async {
    final res = await _statsDao.getAllBestSpeedTrainingTimes();
    final Map<SpeedTrainingType, int> formattedRes = {
      for (var speedTraining in res) speedTraining.type: speedTraining.time
    };

    return formattedRes;
  }

  Future<int?> getBestGameTime(GameType type) async {
    final res = await _statsDao.getBestGameTime(type);

    return res?.time;
  }

  Future<Map<GameType, int>> getAllBestGamesTimes() async {
    final res = await _statsDao.getAllBestGamesTimes();
    final Map<GameType, int> formattedRes = {
      for (var game in res) game.type: game.time
    };

    return formattedRes;
  }

  Future<MentalTrainingStats?> getMentalTrainingStats(
      MentalTrainingType type) async {
    return await _statsDao.getMentalTrainingStats(type);
  }

  Future<Map<MentalTrainingType, MentalTrainingStats>>
      getAllMentalTrainingStats(MentalTrainingType type) async {
    final res = await _statsDao.getAllMentalTrainingStats(type);
    final Map<MentalTrainingType, MentalTrainingStats> formattedRes = {
      for (var mentalTraining in res) mentalTraining.type: mentalTraining
    };

    return formattedRes;
  }

  Future<bool> insertSpeedTrainingTime(SpeedTrainingTime speedTime) async {
    final res = await _statsDao.insertSpeedTrainingTime(speedTime);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (res) speedTimesChanged.notifyListeners();

    return res;
  }

  Future<bool> insertGameTime(GameTime speedTime) async {
    final res = await _statsDao.insertGameTime(speedTime);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (res) gamesTimesChanged.notifyListeners();

    return res;
  }

  Future<bool> increaseMentalTrainingCorrectAnswers(
      MentalTrainingType type) async {
    final res = await _statsDao.increaseMentalTrainingCorrectAnswers(type);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (res) mentalStatsChanged.notifyListeners();
    return res;
  }
}
