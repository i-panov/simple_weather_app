import 'package:simple_weather_app/exceptions/app_exception.dart';

class ApiException extends AppException {
  final int code;
  final Map<String, String>? validationErrors;

  ApiException(String message, this.code, {this.validationErrors}): super(message);

  @override
  String toString() => "$runtimeType($message, $code, $validationErrors)";
}
