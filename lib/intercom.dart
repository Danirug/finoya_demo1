// lib/intercom.dart
import 'package:flutter/foundation.dart';
import 'package:js/js.dart' as js;

@js.JS('window.Intercom')
external void intercom(String command, [dynamic options]);

void logIntercomEvent(String eventName) {
  if (kIsWeb) {
    print('Logging Intercom event: $eventName');
    intercom('trackEvent', eventName);
  }
}

void updateIntercom() {
  if (kIsWeb) {
    intercom('update', {
      'last_request_at': (DateTime.now().millisecondsSinceEpoch / 1000).floor()
    });
  }
}

void showIntercomMessenger() {
  if (kIsWeb) {
    intercom('show');
  }
}