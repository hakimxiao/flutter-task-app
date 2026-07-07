import 'dart:ui';

Color strengthenColor(Color color, double factor) {
  int r = ((_colorChannel(color.r) * factor).clamp(0, 255)).toInt();
  int g = ((_colorChannel(color.g) * factor).clamp(0, 255)).toInt();
  int b = ((_colorChannel(color.b) * factor).clamp(0, 255)).toInt();

  return Color.fromARGB(_colorChannel(color.a), r, g, b);
}

List<DateTime> generateWeekDates(int weekOfSet) {
  final today = DateTime.now();
  DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

  startOfWeek = startOfWeek.add(Duration(days: weekOfSet * 7));

  return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
}

String rgbToHex(Color color) {
  return '${_colorChannel(color.r).toRadixString(16).padLeft(2, '0')}${_colorChannel(color.g).toRadixString(16).padLeft(2, '0')}${_colorChannel(color.b).toRadixString(16).padLeft(2, '0')}';
}

Color hexToRgb(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

int _colorChannel(double value) {
  return (value * 255).round().clamp(0, 255);
}
