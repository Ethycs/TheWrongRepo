@JS()
library speechsdk;

import 'package:js/js.dart';

@JS('listenToVoice')
external void listenToVoice();

@JS('stopListening')
external void stopListening();

@JS('toggleListening')
external void toggleListening();
