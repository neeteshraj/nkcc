import 'dart:math';

class RequestIdGenerator {
  static String generate() {
    final random = Random();
    final randomDigits = List.generate(12, (_) => random.nextInt(10)).join();
    return "NKCC-$randomDigits";
  }
}
