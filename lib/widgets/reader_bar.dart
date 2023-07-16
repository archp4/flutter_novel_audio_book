// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:novel_audiobook_version/models/chapter.dart';
import 'package:novel_audiobook_version/models/const_value.dart';

class ReaderBar extends StatelessWidget {
  final int selectIndex;
  final List<Chapter> chapterList;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final VoidCallback onSettings;
  final VoidCallback onAudioBook;
  final VoidCallback onChapterList;
  const ReaderBar({
    Key? key,
    required this.selectIndex,
    required this.chapterList,
    required this.onNext,
    required this.onPrev,
    required this.onSettings,
    required this.onAudioBook,
    required this.onChapterList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: ConstantValue.defaultPadding),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onChapterList,
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: onSettings,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: onAudioBook,
            icon: const Icon(Icons.book_online),
          ),
          IconButton(
            onPressed: onPrev,
            icon: Icon(
              Icons.arrow_back_ios,
              color: selectIndex > 0 ? Colors.white : Colors.white12,
            ),
          ),
          IconButton(
            onPressed: onNext,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: selectIndex < chapterList.length - 1
                  ? Colors.white
                  : Colors.white12,
            ),
          ),
        ],
      ),
    );
  }
}
