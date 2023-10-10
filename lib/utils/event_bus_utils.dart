import 'dart:async';

import 'package:daystodieutils/module/event/login_event.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:event_bus/event_bus.dart';

class EventBusUtils {
  static EventBus? _instance;

  static EventBus bus() {
    _instance ??= EventBus();
    return _instance!;
  }

  static void pushLoginEvent(bool isLogin) {
    "pushLoginEvent: $isLogin".logD();
    bus().fire(LoginEvent(isLogin));
  }

  static StreamSubscription<LoginEvent> listenLoginEvent(Function callback) {
    return bus().on<LoginEvent>().listen((event) {
      "listenLoginEvent: ${event.isLogin}".logD();
      callback(event);
    });
  }
}
