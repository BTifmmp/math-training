import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:math_training/database/models/game_stats.dart';
import 'package:math_training/database/models/mental_training_stats.dart';
import 'package:math_training/database/models/speed_training_stats.dart';
import 'package:math_training/database/models/training_types.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';

part 'statisitcs_state.dart';

class StatisitcsCubit extends Cubit<StatisticsState> {
  final StatisticRepository _statisticRepository;

  StatisitcsCubit({required statisticRepository})
      : _statisticRepository = statisticRepository,
        super(StatisticsInitial());

  void refreshOnSpeedChange(void Function() onChnage) {
    _statisticRepository.speedTimesChanged.addListener(onChnage);
  }

  void refreshOnMentalChange(void Function() onChnage) {
    _statisticRepository.mentalStatsChanged.addListener(onChnage);
  }

  void refreshOnGamesChange(void Function() onChnage) {
    _statisticRepository.gamesTimesChanged.addListener(onChnage);
  }

  Future<void> getBestSpeedTrainingTime(SpeedTrainingType type) async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getBestSpeedTrainingTime(type);
    emit(StatisticsSuccessBestTime(bestTime: res));
  }

  Future<void> getAllBestSpeedTrainingTimes() async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getAllBestSpeedTrainingTimes();
    emit(StatisticsSuccessAllBestTimes(bestTimes: res));
  }

  Future<void> getBestGameTime(GameType type) async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getBestGameTime(type);
    emit(StatisticsSuccessBestTimeGame(bestTimeGame: res));
  }

  Future<void> getAllBestGamesTimes() async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getAllBestGamesTimes();
    emit(StatisticsSuccessAllBestTimesGames(bestTimesGames: res));
  }

  Future<void> getMentalTrainingStats(MentalTrainingType type) async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getMentalTrainingStats(type);
    emit(StatisticsSuccessMentalTrainingStats(mentalStats: res));
  }

  Future<void> getAllMentalTrainingStats() async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getAllMentalTrainingStats();
    emit(StatisticsSuccessAllMentalTrainingStats(allMentalStats: res));
  }

  Future<void> insertSpeedTrainingTime(SpeedTrainingTime speedTime) async {
    emit(StatisticsLoading());
    await _statisticRepository.insertSpeedTrainingTime(speedTime);
    emit(StatisticsSuccess());
  }

  Future<void> insertGameTime(GameTime speedTime) async {
    emit(StatisticsLoading());
    await _statisticRepository.insertGameTime(speedTime);
    emit(StatisticsSuccess());
  }

  Future<void> increaseMentalTrainingCorrectAnswers(
      MentalTrainingType type) async {
    emit(StatisticsLoading());
    await _statisticRepository.increaseMentalTrainingCorrectAnswers(type);
    emit(StatisticsSuccess());
  }
}
