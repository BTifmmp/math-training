import 'dart:math';

import 'package:math_training/utils/generation_common.dart';

num generateNextAdd(int upperRange, bool allowFractions) {
  final rng = Random();

  final num number = allowFractions && rng.nextDouble() < 0.2
      ? rng.nextInt((upperRange).floor()) / 10
      : rng.nextInt((upperRange).floor());

  return number;
}

num generateNextSubstract(
    num previousNumber, int upperRange, bool allowFractions) {
  if (previousNumber == 0) return 0;

  final rng = Random();

  final num number = allowFractions && rng.nextDouble() < 0.2
      ? rng.nextInt((min(previousNumber, upperRange)).floor()) / 10
      : rng.nextInt((min(previousNumber, upperRange)).floor());

  return number;
}

num generateNextDivision(num previousNumber, int upperRange) {
  // Second number must divide first number wihtout fraction
  if (previousNumber == 0) return 1;

  final rng = Random();
  List<int> divisors = getDivisorsSorted(previousNumber.floor());

  // If possible remove 1 and the number itself
  if (divisors.length >= 3) {
    divisors.removeAt(0);
    divisors.removeLast();
  }

  final num number = divisors[rng.nextInt(divisors.length)];

  return number;
}

num generateNextMultiplication(num previousNumber, int upperRange) {
  final rng = Random();

  final num number =
      max(rng.nextInt(max(pow(upperRange, 2) ~/ previousNumber, 1)), 2);

  return number;
}
