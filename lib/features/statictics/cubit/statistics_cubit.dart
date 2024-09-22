import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:math_training/features/statictics/domain/statistics.dart';
import 'package:math_training/features/statictics/repository/statistic_repository.dart';

part 'statisitcs_state.dart';

class StatisitcsCubit extends Cubit<StatisticsState> {
  final StatisticRepository _statisticRepository;
  StreamSubscription<Statistics>? _statisticSubscription;

  StatisitcsCubit({required statisticRepository})
      : _statisticRepository = statisticRepository,
        super(StatisticsInitial());

  Future<void> requestSubscription() async {
    _statisticSubscription?.cancel();

    emit(StatisticsLoading());

    _statisticSubscription = _statisticRepository.getStatistics().listen(
        (stats) => StatisticsSuccess(statistics: stats),
        onError: (_, __) => StatisticsFailure());
  }

  @override
  Future<void> close() {
    _statisticSubscription?.cancel(); // Cancel the stream subscription
    return super.close();
  }
}
