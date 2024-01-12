import 'dart:math';

extension DoubleUtils on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
  double degreesToRadians(double graus) => graus * (pi / 180.0);
}


