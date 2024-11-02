part of 'statistics_cubit.dart';

@immutable
sealed class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}

final class StatisticsLoading extends StatisticsState {}

final class StatisticsSuccessAllBestTimes extends StatisticsState {
  final Map<SpeedTrainingType, int> bestTimes;
  StatisticsSuccessAllBestTimes({required this.bestTimes});
}

final class StatisticsSuccessBestTime extends StatisticsState {
  final int? bestTime;
  StatisticsSuccessBestTime({required this.bestTime});
}

final class StatisticsSuccessAllBestTimesGames extends StatisticsState {
  final Map<GameType, int> bestTimesGames;
  StatisticsSuccessAllBestTimesGames({required this.bestTimesGames});
}

final class StatisticsSuccessBestTimeGame extends StatisticsState {
  final int? bestTimeGame;
  StatisticsSuccessBestTimeGame({required this.bestTimeGame});
}

final class StatisticsSuccessAllMentalTrainingStats extends StatisticsState {
  final Map<MentalTrainingType, MentalTrainingStats> allMentalStats;
  StatisticsSuccessAllMentalTrainingStats({required this.allMentalStats});
}

final class StatisticsSuccessMentalTrainingStats extends StatisticsState {
  final MentalTrainingStats? mentalStats;
  StatisticsSuccessMentalTrainingStats({required this.mentalStats});
}

final class StatisticsSuccess extends StatisticsState {}

final class StatisticsFailure extends StatisticsState {}
