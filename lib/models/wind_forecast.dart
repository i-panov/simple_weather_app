/// Прогноз ветра
class WindForecast {
  /// Скорость ветра в м/с
  final int speed;

  /// Порывы ветра в м/с
  final int gusts;

  /// Направление ветра
  final String direction;

  WindForecast({required this.speed, required this.gusts, required this.direction});
}
