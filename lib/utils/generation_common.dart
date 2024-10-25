typedef NumberPair = (num, num);

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
