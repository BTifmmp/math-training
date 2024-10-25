import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

  void refreshOnSpeedChnage(void Function() onChnage) {
    _statisticRepository.speedTimesChanged.addListener(onChnage);
  }

  void refreshOnMentalChnage(void Function() onChnage) {
    _statisticRepository.mentalStatsChanged.addListener(onChnage);
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

  Future<void> getMentalTrainingStats(MentalTrainingType type) async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getMentalTrainingStats(type);
    emit(StatisticsSuccessMentalTrainingStats(mentalStats: res));
  }

  Future<void> getAllMentalTrainingStats(MentalTrainingType type) async {
    emit(StatisticsLoading());
    final res = await _statisticRepository.getAllMentalTrainingStats(type);
    emit(StatisticsSuccessAllMentalTrainingStats(allMentalStats: res));
  }

  Future<void> insertSpeedTrainingTime(SpeedTrainingTime speedTime) async {
    emit(StatisticsLoading());
    await _statisticRepository.insertSpeedTrainingTime(speedTime);
    emit(StatisticsSuccess());
  }

  Future<void> increaseMentalTrainingCorrectAnswers(
      MentalTrainingType type) async {
    emit(StatisticsLoading());
    await _statisticRepository.increaseMentalTrainingCorrectAnswers(type);
    emit(StatisticsSuccess());
  }
}
