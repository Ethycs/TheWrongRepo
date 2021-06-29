@JS()
library app_ffi_js;

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

@JS('login')
external void login();

@JS('dialogState')
external set _dialogState(void Function() f);

void dialogState() {
  print("We Got Dialog!");
}

void main() {
  _dialogState = allowInterop(dialogState);
}
