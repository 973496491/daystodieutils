
import 'package:logger/logger.dart';

extension StringLoggerExt on String {

  void logD() {
    Logger().d(this);
  }

  void logE() {
    Logger().e(this);
  }

  void logI() {
    Logger().i(this);
  }
}