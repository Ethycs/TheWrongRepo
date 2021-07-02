@JS()
library app_ffi_js;

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

@JS('fluxState')
external set _fluxState(void Function() f); //JsObject diff

void fluxState() {
  print("Dialog!");
}

/// Allows assigning a function to be callable from `window.functionName()`
@JS('functionName')
external set _functionName(void Function() f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void functionName();

void _someDartFunction() {
  print('Hello from Dart!');
}

void main() {
  _fluxState = allowInterop(fluxState);
  _functionName = allowInterop(_someDartFunction);
  // JavaScript code may now call `functionName()` or `window.functionName()`.
}
