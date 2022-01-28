import 'config.dart';
import 'dart:developer' as dev;

class Logger {
  static void e(dynamic anything) {
    print('❌ $anything');
  }

  static void d(dynamic anything) {
    if (Env.isDebugMode) {
      print('🐛 $anything');
    }
  }

  static void i(dynamic anything) {
    if (Env.isDebugMode) {
      print('ℹ️ $anything');
    }
  }

  static void v(dynamic anything) {
    if (Env.isDebugMode) {
      dev.log('📜 $anything');
    }
  }
}
