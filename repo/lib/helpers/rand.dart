import 'dart:math';

int randInt({int min = 1, int max = 100}) {
  final random = Random();

  // Generate a random integer between min (inclusive) and max (exclusive)
  return min + random.nextInt(max - min);
}

double randDouble({double min = 1, double max = 100}) {
  final random = Random();

  // Generate a random double between min (inclusive) and max (exclusive)
  return min + random.nextDouble() * (max - min);
}
