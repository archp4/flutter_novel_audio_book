// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/services/tts.dart';

class AudioBookDialog extends StatefulWidget {
  final String text;
  final String imageURL;
  const AudioBookDialog({
    Key? key,
    required this.text,
    required this.imageURL,
  }) : super(key: key);

  @override
  State<AudioBookDialog> createState() => _AudioBookDialogState();
}

class _AudioBookDialogState extends State<AudioBookDialog> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  initState() {
    super.initState();
    init();
    setAudio();
  }

  init() async {
    audioPlayer.onPlayerStateChanged.listen((currentState) =>
        setState(() => isPlaying = currentState == PlayerState.playing));

    audioPlayer.onDurationChanged.listen(
        (currentDuration) => setState(() => duration = currentDuration));

    audioPlayer.onPositionChanged.listen(
        (currentPosition) => setState(() => position = currentPosition));
  }

  List list = [];

  Future setAudio() async {
    NinjaTTS tts = NinjaTTS();
    var data = await tts.ttsToFile(text: widget.text);
    print(data);
    // audioPlayer.setSourceUrl(tts.address + tts.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/images/overgeared.jpg',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Chapter Title",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);

                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstantValue.defaultPadding),
              child: Row(
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration - position))
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.resume();
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    String time = '';
    if (duration.inDays > 0) {
      time = '${duration.inDays}:';
    }
    if (duration.inHours > 0) {
      time = '$time${duration.inHours}:';
    }
    time = '$time${duration.inMinutes}:';
    time = '$time${duration.inSeconds}';
    return time;
  }

  @override
  void dispose() async {
    super.dispose();
  }
}
