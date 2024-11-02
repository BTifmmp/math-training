String formatDuration(Duration duration) {
  String negativeSign = duration.isNegative ? '-' : '';
  String digitSeconds = duration.inSeconds.abs().toString();
  String twoDigitMiliseconds =
      (duration.inMilliseconds.remainder(1000).abs() / 10)
          .round()
          .toString()
          .padLeft(2, "0");

  return "$negativeSign$digitSeconds.${twoDigitMiliseconds}s";
}
