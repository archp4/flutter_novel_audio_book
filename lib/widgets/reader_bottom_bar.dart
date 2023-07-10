// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/chapter.dart';
import 'package:novel_audiobook_version/models/const_value.dart';

class ReaderBottombar extends StatelessWidget {
  final int selectIndex;
  final List<Chapter> chapterList;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  const ReaderBottombar({
    Key? key,
    required this.selectIndex,
    required this.chapterList,
    required this.onNext,
    required this.onPrev,
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
            onPressed: () {},
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
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
              color: selectIndex < chapterList.length
                  ? Colors.white
                  : Colors.white12,
            ),
          ),
        ],
      ),
    );
  }
}
