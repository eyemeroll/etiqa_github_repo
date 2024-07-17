String formatNumber(int number) {
  if (number >= 1000) {
    // Convert the number to a double with one decimal place
    double value = number / 1000;
    return '${value.toStringAsFixed(1)}k';
  }
  return number.toString();
}