extension TwoDecimalPlace on double {
  String roundToTwo() {
    return double.parse(toString()).toStringAsFixed(2);
  }
}
