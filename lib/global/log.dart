import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static void i(Object? log) {
    _logger.i(log);
  }

  static void d(Object? log) {
    _logger.d(log);
  }

  static void w(Object? log) {
    _logger.w(log);
  }

  static void e(Object? log) {
    _logger.e(log);
  }

  static void f(Object? log) {
    _logger.f(log);
  }
}
