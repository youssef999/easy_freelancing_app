

import 'dart:developer' as developer;

class Ui {

  static const AppName = "PICKY BUD";
 
  static logSuccess(Object msg) {
    developer.log('\x1B[32m${msg.toString()}\x1B[0m');
  }

  static logInfo(Object msg) {
    developer.log('\x1B[34m${msg.toString()}\x1B[0m');
  }

  static logWarning(Object msg) {
    developer.log('\x1B[33m${msg.toString()}\x1B[0m');
  }

  static logError(Object msg) {
    developer.log('\x1B[31m${msg.toString()}\x1B[0m');
  }
 
}
