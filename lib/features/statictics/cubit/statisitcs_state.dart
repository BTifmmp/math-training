part of 'statistics_cubit.dart';

@immutable
sealed class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}

final class StatisticsLoading extends StatisticsState {}

final class StatisticsSuccess extends StatisticsState {
  final Statistics statistics;

  StatisticsSuccess({required this.statistics});
}

final class StatisticsFailure extends StatisticsState {}
