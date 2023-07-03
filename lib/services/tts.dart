import 'package:flutter_tts/flutter_tts.dart';

class NinjaTTS {
  final name = 'temp.wav';
  final address =
      ' /storage/emulated/0/Android/data/com.example.novel_audiobook_version/files/';
  FlutterTts tts = FlutterTts();

  Future ttsToFile({required String text}) async {
    return await tts.synthesizeToFile(text, 'temp.wav');
  }
}
