import androidx.annotation.NonNull;
import android.util.Log;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import com.microsoft.cognitiveservices.speech.CancellationDetails;
import com.microsoft.cognitiveservices.speech.ResultReason;
import com.microsoft.cognitiveservices.speech.SpeechConfig;
import com.microsoft.cognitiveservices.speech.SpeechRecognitionResult;
import com.microsoft.cognitiveservices.speech.RecognitionEventArgs;
import com.microsoft.cognitiveservices.speech.SpeechRecognizer;


public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.androids.section/cognitiveservices";
    //Cognitive Services Info
    private static String speechSubscriptionKey = "c54b24d316544bf6816a232061ad1c76";
    // Replace below with your own service region (e.g., "westus").
    private static String serviceRegion = "westus";
    private SpeechConfig config;
    private SpeechRecognizer reco;

    try{
        config = SpeechConfig.fromSubscription(speechSubscriptionKey,serviceRegion);
        reco = new SpeechRecognizer(config);
    } catch (Exception ex){
        createAndShowDialog(ex, "Error");
    }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
  super.configureFlutterEngine(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler(
          (call, result) -> {
            // Note: this method is invoked on the main thread.
            // TODO
          }
        );
  }
}


private void listenToVoice(){
    try{
        config = SpeechConfig.fromSubscription(speechSubscriptionKey,serviceRegion);
        reco = new SpeechRecognizer(config);
        reco.recognizing.addEventListener((o, speechRecognitionResultEventArgs) -> {
            final String s = speechRecognitionResultEventArgs.getResult().getText();
            Log.i("TEST","INTERMEDIATE RESULT RECEIVED: " + s);
        });
        reco.recognized.addEventListener((o, speechRecognitionResultEventArgs) -> {
            final String s = speechRecognitionResultEventArgs.getResult().getText();
            Log.i("TEST", "FINAL RESULT RECEIVED: " + s);
            postPhrase(s);
        });
        Future<Void> task = reco.startContinuousRecognitionAsync();
        setOnTaskCompletedListener(task, result -> {
            Log.i("TEST", "EVENT STARTED!!!");
        });
    } catch (Exception ex){
        createAndShowDialog(ex, "Error");
    }
}