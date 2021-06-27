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
