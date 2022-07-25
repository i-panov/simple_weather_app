/// Тип осадков
enum PrecipitationType { rain, snow }

PrecipitationType? parsePrecipitationType(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  return {
    'rain': PrecipitationType.rain,
    'snow': PrecipitationType.snow,
  }[value];
}
