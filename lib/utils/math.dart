List<int> getDivisorsSorted(int num) {
  List<int> divisors = [];

  for (int i = 1; i <= num; i++) {
    if (num % i == 0) {
      divisors.add(i); // Add i as a divisor
    }
  }

  return divisors;
}
