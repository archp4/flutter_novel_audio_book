// // ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element
// // ignore_for_file: avoid_print, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter_tts/flutter_tts.dart';
// // import 'package:novel_audiobook_version/widgets/reader_appbar.dart';
// import 'package:novel_audiobook_version/models/chapter.dart';
// import 'package:novel_audiobook_version/models/const_value.dart';
// import 'package:novel_audiobook_version/models/novel.dart';
// import 'package:novel_audiobook_version/models/page_navigatior.dart';
// import 'package:novel_audiobook_version/models/tts_state.dart';
// import 'package:novel_audiobook_version/widgets/reader_appbar.dart';
// import 'package:novel_audiobook_version/widgets/reader_bottom_bar.dart';
// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:async';

// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class ChapterReader extends StatefulWidget {
//   int selectIndex;
//   Novel novel;
//   Chapter chapter;
//   ChapterReader({
//     super.key,
//     required this.novel,
//     required this.selectIndex,
//     required this.chapter,
//   });

//   @override
//   State<ChapterReader> createState() => _ChapterReaderState();
// }

// class _ChapterReaderState extends State<ChapterReader> {
//   String data = "";
//   bool isDataLoaded = false;
//   late FlutterTts flutterTts;
//   double volume = 1;
//   double pitch = 0.9;
//   double rate = 0.5;
//   int? speechinIndex;
//   TtsState ttsState = TtsState.stopped;
//   final scrollController = ScrollController();

//   get isPlaying => ttsState == TtsState.playing;
//   get isStopped => ttsState == TtsState.stopped;
//   get isPaused => ttsState == TtsState.paused;
//   get isContinued => ttsState == TtsState.continued;
//   bool customPaused = false;

//   bool get isIOS => !kIsWeb && Platform.isIOS;
//   bool get isAndroid => !kIsWeb && Platform.isAndroid;
//   bool get isWindows => !kIsWeb && Platform.isWindows;
//   bool get isWeb => kIsWeb;
//   var tempList = <String>[];

//   getFileData({required String novelName, required String fileName}) async {
//     var path = "assets/files/$novelName/$fileName";
//     data = await rootBundle.loadString(path);
//     isDataLoaded = true;
//     tempList = data.trim().split(RegExp(r'(\n)'));
//     setState(() {});
//   }

//   @override
//   initState() {
//     super.initState();
//     readData();
//     initTts();
//   }

//   initTts() {
//     flutterTts = FlutterTts();

//     _setAwaitOptions();

//     if (isAndroid) {
//       _getDefaultEngine();
//       _getDefaultVoice();
//     }

//     flutterTts.setStartHandler(() {
//       setState(() {
//         print("Playing");
//         ttsState = TtsState.playing;
//       });
//     });

//     if (isAndroid) {
//       flutterTts.setInitHandler(() {
//         setState(() {
//           print("TTS Initialized");
//         });
//       });
//     }

//     flutterTts.setCompletionHandler(() {
//       setState(() {
//         print("Complete");
//         ttsState = TtsState.stopped;
//       });
//     });

//     flutterTts.setCancelHandler(() {
//       setState(() {
//         print("Cancel");
//         ttsState = TtsState.stopped;
//       });
//     });

//     flutterTts.setPauseHandler(() {
//       setState(() {
//         print("Paused");
//         ttsState = TtsState.paused;
//       });
//     });

//     flutterTts.setContinueHandler(() {
//       setState(() {
//         print("Continued");
//         ttsState = TtsState.continued;
//       });
//     });

//     flutterTts.setErrorHandler((msg) {
//       setState(() {
//         print("error: $msg");
//         ttsState = TtsState.stopped;
//       });
//     });
//   }

//   Future _getDefaultEngine() async {
//     var engine = await flutterTts.getDefaultEngine;
//     if (engine != null) {
//       print(engine);
//     }
//   }

//   Future _getDefaultVoice() async {
//     var voice = await flutterTts.getDefaultVoice;
//     if (voice != null) {
//       print(voice);
//     }
//   }

//   Future _speak() async {
//     await flutterTts.setVolume(volume);
//     await flutterTts.setSpeechRate(rate);
//     await flutterTts.setPitch(pitch);

//     if (isPaused) {
//       for (var i = speechinIndex!; i < tempList.length; i++) {
//         itemScrollController.jumpTo(index: i);
//         setState(() => speechinIndex = i);
//         await flutterTts.speak(tempList[i]);
//         customPaused = true;
//       }
//     } else {
//       for (var i = 0; i < tempList.length; i++) {
//         if (!isPlaying) {
//           const Duration(seconds: 1);
//         }
//         itemScrollController.jumpTo(index: i);
//         setState(() {
//           speechinIndex = i;
//         });
//         await flutterTts.speak(!isPlaying ? tempList[i] : "");
//       }
//     }
//   }

//   Future _setAwaitOptions() async {
//     await flutterTts.awaitSpeakCompletion(true);
//   }

//   Future _stop() async {
//     await flutterTts.stop();
//   }

//   Future _pause() async {
//     await flutterTts.pause();
//     setState(() {
//       customPaused = true;
//     });
//   }

//   readData() async {
//     await getFileData(
//       novelName: widget.novel.name,
//       fileName: widget.chapter.addressNo,
//     );
//   }

//   String fixName({required String name}) =>
//       name.substring(0, 1).toUpperCase() + name.substring(1);
//   final ItemScrollController itemScrollController = ItemScrollController();
//   @override
//   Widget build(BuildContext context) {
//     var title =
//         "${fixName(name: widget.novel.name)}/${widget.novel.chapters[widget.selectIndex].name}";
//     return Scaffold(
//       appBar: ReaderAppbar(
//         isPlaying: isPlaying,
//         onPause: () async {
//           PageNavigation.pop(context);
//         },
//         onSpeak: _speak,
//         title: title,
//         context: context,
//       ),
//       body: Stack(
//         children: [
//           if (!isDataLoaded) const Center(child: CircularProgressIndicator()),
//           // Container(
//           //   padding: const EdgeInsets.all(ConstantValue.defaultPadding),
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     children: [
//           //       Text(
//           //         "Chapter ${widget.novel.chapters[widget.selectIndex].name}",
//           //         style: Theme.of(context).textTheme.headlineMedium,
//           //       ),
//           //       const SizedBox(height: ConstantValue.defaultPadding),

//           //       const SizedBox(height: ConstantValue.defaultPadding * 3),
//           //     ],
//           //   ),
//           // ),
//           Container(
//             padding: const EdgeInsets.all(ConstantValue.defaultPadding),
//             child: ScrollablePositionedList.builder(
//               shrinkWrap: true,
//               itemCount: tempList.length,
//               itemScrollController: itemScrollController,
//               itemBuilder: (_, index) {
//                 return index != speechinIndex
//                     ? Text(
//                         tempList[index],
//                         style: Theme.of(context).textTheme.bodyMedium,
//                         textAlign: TextAlign.justify,
//                       )
//                     : Container(
//                         decoration: const BoxDecoration(color: Colors.red),
//                         child: Text(
//                           tempList[index],
//                           style: Theme.of(context).textTheme.bodyMedium,
//                           textAlign: TextAlign.justify,
//                         ),
//                       );
//               },
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             height: ConstantValue.defaultPadding * 3,
//             child: ReaderBottombar(
//               chapter: widget.chapter,
//               selectIndex: widget.selectIndex,
//               novel: widget.novel,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _stop();
//   }
// }
