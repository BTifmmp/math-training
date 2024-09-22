String formatDuration(Duration duration) {
  String negativeSign = duration.isNegative ? '-' : '';
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
  String twoDigitMiliseconds =
      twoDigits((duration.inMilliseconds.remainder(1000).abs() / 10).round());

  return "$negativeSign$twoDigitMinutes:$twoDigitSeconds:$twoDigitMiliseconds";
}
