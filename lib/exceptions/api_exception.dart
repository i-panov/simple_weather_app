import 'package:simple_weather_app/exceptions/app_exception.dart';

class ApiException extends AppException {
  final int code;

  ApiException(String message, this.code): super(message);

  @override
  String toString() => "$runtimeType($message, $code)";
}
