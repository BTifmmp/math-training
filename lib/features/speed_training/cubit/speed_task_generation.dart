import 'dart:math';
import 'package:math_training/utils/math.dart';

typedef NumberPair = (num, num);

NumberPair generateRoot(int upperRange, bool allowThirds) {
  final rng = Random();

  final int root = allowThirds && rng.nextDouble() < 0.3 ? 3 : 2;

  final num number = root == 3
      ? pow(rng.nextInt(pow(upperRange, 1 / 3).floor()), 3)
      : pow(rng.nextInt(sqrt(upperRange).floor()), 2);

  return (number, root);
}

NumberPair generatePower(int upperRange, bool allowThirds) {
  final rng = Random();

  final int power = allowThirds && rng.nextDouble() < 0.3 ? 3 : 2;

  final num number = power == 3
      ? rng.nextInt(pow(upperRange, 1 / 3).floor())
      : rng.nextInt(sqrt(upperRange).floor());

  return (number, power);
}

NumberPair generateAddPair(int upperRange, bool allowFractions) {
  final rng = Random();

  final num firstNum = allowFractions && rng.nextDouble() < 0.2
      ? rng.nextInt(upperRange) / 10
      : rng.nextInt(upperRange);

  final num secondNum = allowFractions && rng.nextDouble() < 0.2
      ? rng.nextInt(upperRange) / 10
      : rng.nextInt(upperRange);

  return (firstNum, secondNum);
}

NumberPair generateSubstractPair(int upperRange, bool allowFractions) {
  final rng = Random();

  final num firstNum = rng.nextDouble() < 0.2
      ? rng.nextInt(upperRange) / 10
      : rng.nextInt(upperRange);

  final num secondNum = rng.nextDouble() < 0.2
      ? rng.nextInt(upperRange) / 10
      : rng.nextInt(upperRange);

  if (firstNum > secondNum) return (firstNum, secondNum);
  return (secondNum, firstNum);
}

NumberPair generateMultiplicationPair(int upperRange) {
  final rng = Random();

  return (rng.nextInt(upperRange), rng.nextInt(upperRange));
}

NumberPair generateDivisionPair(int upperRange) {
  // Second number must divide first number wihtout fraction
  final rng = Random();
  final firstNum = max(1, rng.nextInt(upperRange) * rng.nextInt(upperRange));
  List<int> divisors = getDivisorsSorted(firstNum.floor());

  // If possible remove 1 and the number itself
  if (divisors.length >= 3) {
    divisors.removeAt(0);
    divisors.removeLast();
  }
  final secondNum = divisors[rng.nextInt(divisors.length)];

  return (firstNum, secondNum);
}
