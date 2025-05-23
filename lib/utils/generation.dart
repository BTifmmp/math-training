import 'dart:math';

typedef NumberPair = (num, num);

int gcd(int a, int b) {
  while (b != 0) {
    var temp = b;
    b = a % b;
    a = temp;
  }

  return a;
}

List<int> getDivisorsSorted(int num) {
  List<int> divisors = [];

  for (int i = 1; i <= num; i++) {
    if (num % i == 0) {
      divisors.add(i); // Add i as a divisor
    }
  }

  return divisors;
}

num removeUnnecesaryDecimalZero(num n) {
  return num.parse(n.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), ''));
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

  final num firstNum = allowFractions && rng.nextDouble() < 0.2
      ? rng.nextInt(upperRange) / 10
      : rng.nextInt(upperRange);

  final num secondNum = allowFractions && rng.nextDouble() < 0.2
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
