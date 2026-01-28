import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechService {
  final SpeechToText _stt = SpeechToText();
  final FlutterTts _tts = FlutterTts();

  Future<void> init() async {
    await _stt.initialize();
    await _tts.setLanguage("es-ES");
    await _tts.setSpeechRate(0.5); // Chef calmado
    await _tts.setPitch(0.9);      // Chef profesional
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  void listen(Function(String) onResult) async {
    if (!_stt.isListening) {
      await _stt.listen(onResult: (result) {
        onResult(result.recognizedWords);
      });
    }
  }

  void stopListening() async {
    await _stt.stop();
  }
}
