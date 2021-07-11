@JS()
library app_ffi_js;

import 'dart:async';
import 'dart:js';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';

@JS('listenToVoice')
external void listenToVoice();

@JS('stopListening')
external void stopListening();

@JS('toggleListening')
external void toggleListening();

@JS('refreshToken')
external void refreshToken();

StreamController<String> fluxController = StreamController<String>();

//https://github.com/flutter/flutter/issues/29958
//https://pub.dev/packages/listenable_stream
//https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html
void _dialogState(List<dynamic> input) {
  var stringed = input;
  for (String state in stringed) {
    fluxController.add(state);
  }
  print("Dialog! $stringed");
}

@JS('login')
external void login();

@JS('fluxState')
external set _fluxState(void Function(List<dynamic> input) f); //JsObject diff

Stream<String> stateQueue(List<dynamic> state) async* {
  for (String item in state) {
    yield item;
  }
}

@JS()
external void fluxState();

void appInterops() {
  _fluxState = allowInterop(_dialogState);
  // JavaScript code may now call `functionName()` or `window.functionName()`.
}
