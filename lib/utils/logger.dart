import 'package:logger/logger.dart';

class MyLogger {
  static final logger = Logger();
  static void log(data) {
    logger.i(data);
  }

  static void wtf(data) {
    logger.f(data);
  }
}
