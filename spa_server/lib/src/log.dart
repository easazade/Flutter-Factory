import 'config.dart';
import 'dart:developer' as dev;

class Logger {
  static void e(dynamic anything) {
    print('â $anything');
  }

  static void d(dynamic anything) {
    if (Env.isDebugMode) {
      print('đ $anything');
    }
  }

  static void i(dynamic anything) {
    if (Env.isDebugMode) {
      print('âšī¸ $anything');
    }
  }

  static void v(dynamic anything) {
    if (Env.isDebugMode) {
      dev.log('đ $anything');
    }
  }
}
