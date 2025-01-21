// // ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element, curly_braces_in_flow_control_structures, unnecessary_null_comparison
// import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:collection/collection.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:novel_audiobook_version/models/const_value.dart';

// class AudioBookDialog extends StatefulWidget {
//   final String text;
//   final String imageURL;
//   final String title;
//   const AudioBookDialog({
//     Key? key,
//     required this.text,
//     required this.title,
//     required this.imageURL,
//   }) : super(key: key);

//   @override
//   State<AudioBookDialog> createState() => _AudioBookDialogState();
// }

// class _AudioBookDialogState extends State<AudioBookDialog> {
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   bool isDownloaded = false;
//   int currentIndex = 0;
//   File? mp3;
//   final PageController controller = PageController();

//   var tempStringList = <String>[];
//   final dio = Dio(
//     BaseOptions(
//       baseUrl: "http://192.168.29.218:4444",
//       receiveDataWhenStatusError: true,
//       connectTimeout: const Duration(seconds: 60), // 60 seconds
//       receiveTimeout: const Duration(seconds: 60), // 60 seconds
//     ),
//   );
//   @override
//   initState() {
//     super.initState();
//     initStringList();
//     init();
//   }

//   init() async {
//     audioPlayer.onPlayerStateChanged.listen((currentState) =>
//         setState(() => isPlaying = currentState == PlayerState.playing));

//     audioPlayer.onDurationChanged.listen(
//         (currentDuration) => setState(() => duration = currentDuration));

//     audioPlayer.onPositionChanged.listen(
//         (currentPosition) => setState(() => position = currentPosition));
//     createTTS(text: tempStringList[0]);
//   }

//   initStringList() {
//     var sliceList = widget.text.split('\n').slices(50);
//     for (var stringList in sliceList) {
//       var result = '';
//       for (var str in stringList) result += str;
//       tempStringList.add(result);
//     }
//   }

//   createTTS({required String text}) async {
//     final createTTS =
//         await dio.get('/create-tts', queryParameters: {'data': text});
//     if (createTTS.statusCode == 200 && createTTS.data) {
//       await downloadFile();
//     } else {
//       debugPrint(createTTS.statusCode.toString());
//       debugPrint(createTTS.data.toString());
//       debugPrint('Errors');
//     }
//   }

//   onChange(int? index) async {
//     setState(() {
//       currentIndex = index!;
//       isDownloaded = false;
//     });
//     await createTTS(text: tempStringList[index!]);
//   }

//   audioUpdate({required bool isForward}) async {
//     if (0 > position.inSeconds && position.inSeconds != duration.inSeconds) {
//       setState(() {
//         if (isForward)
//           position += const Duration(seconds: 10);
//         else
//           position -= const Duration(seconds: 10);
//       });
//     }
//     audioPlayer.resume();
//   }

//   downloadFile() async {
//     try {
//       Directory tempDir = await getTemporaryDirectory();
//       String tempPath = '${tempDir.path}/tts.mp3';

//       final download = await dio.download("/tts", tempPath);
//       if (download.statusCode == 200) {
//         debugPrint("Downloaded Completed");
//         var tempChecker = await File(tempPath).exists();
//         if (tempChecker) {
//           mp3 = File(tempPath);
//           setAudio();
//           debugPrint('File exists');
//           setState(() => isDownloaded = true);
//         }
//       } else {
//         debugPrint("Downloaded Completed");
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   setAudio() {
//     audioPlayer.setSourceDeviceFile(mp3!.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> generatedImage = tempStringList != null
//         ? List.generate(
//             tempStringList.length, (index) => Image.network(widget.imageURL))
//         : [Image.network(widget.imageURL)];
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 250,
//               height: 250,
//               child: PageView(
//                 onPageChanged: onChange,
//                 children: generatedImage,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text('${currentIndex + 1}/${generatedImage.length}'),
//             const SizedBox(height: 32),
//             Text(
//               widget.title,
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             LoadingIndicator(
//               isDownloaded: isDownloaded,
//               onChange: (value) async {
//                 final position = Duration(seconds: value.toInt());
//                 await audioPlayer.seek(position);
//                 await audioPlayer.resume();
//               },
//               duration: duration.inSeconds.toDouble(),
//               position: position.inSeconds.toDouble(),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: ConstantValue.defaultPadding * 1.7,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(formatTime(position)),
//                   Text(formatTime(duration))
//                 ],
//               ),
//             ),
//             AudioControlPanel(
//               isPlaying: isPlaying,
//               isDownloaded: isDownloaded,
//               audioPlayer: audioPlayer,
//               onFowared: () {
//                 audioUpdate(isForward: true);
//               },
//               onRepay: () {
//                 audioUpdate(isForward: false);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//   }
// }

// class PlayButton extends StatelessWidget {
//   const PlayButton({
//     super.key,
//     required this.isPlaying,
//     required this.audioPlayer,
//     required this.isDownloaded,
//   });

//   final bool isPlaying;
//   final bool isDownloaded;
//   final AudioPlayer audioPlayer;

//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 35,
//       backgroundColor: Colors.white,
//       child: IconButton(
//         onPressed: () async {
//           if (isPlaying) {
//             await audioPlayer.pause();
//           } else {
//             if (isDownloaded) await audioPlayer.resume();
//           }
//         },
//         icon: Icon(
//           isPlaying ? Icons.pause : Icons.play_arrow,
//           color: Colors.black,
//           size: ConstantValue.defaultPadding * 2,
//         ),
//       ),
//     );
//   }
// }

// class AudioImageHolder extends StatelessWidget {
//   final String imageUrl;
//   const AudioImageHolder({
//     super.key,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       child: Image.asset(
//         imageUrl,
//         width: double.infinity,
//         height: 350,
//         fit: BoxFit.cover,
//       ),
//     );
//   }
// }

// class LoadingIndicator extends StatelessWidget {
//   final bool isDownloaded;
//   final void Function(double)? onChange;
//   final double duration, position;
//   const LoadingIndicator({
//     Key? key,
//     required this.isDownloaded,
//     required this.onChange,
//     required this.duration,
//     required this.position,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return isDownloaded
//         ? Slider(
//             min: 0,
//             max: duration,
//             value: position,
//             onChanged: onChange,
//           )
//         : const Padding(
//             padding: EdgeInsets.all(ConstantValue.defaultPadding * 1.7),
//             child: LinearProgressIndicator(),
//           );
//   }
// }

// class AudioControlPanel extends StatelessWidget {
//   final bool isPlaying;
//   final bool isDownloaded;
//   final AudioPlayer audioPlayer;
//   final VoidCallback onFowared;
//   final VoidCallback onRepay;

//   const AudioControlPanel({
//     Key? key,
//     required this.isPlaying,
//     required this.isDownloaded,
//     required this.audioPlayer,
//     required this.onFowared,
//     required this.onRepay,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         IconButton(
//           onPressed: () {
//             onRepay();
//           },
//           icon: const Icon(
//             Icons.replay_10,
//             size: ConstantValue.defaultPadding * 2,
//           ),
//         ),
//         PlayButton(
//           isPlaying: isPlaying,
//           isDownloaded: isDownloaded,
//           audioPlayer: audioPlayer,
//         ),
//         IconButton(
//           onPressed: () {
//             onFowared();
//           },
//           icon: const Icon(
//             Icons.forward_10,
//             size: ConstantValue.defaultPadding * 2,
//           ),
//         ),
//       ],
//     );
//   }
// }
