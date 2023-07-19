import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/widgets/display_home_novel_tile.dart';

Widget getScrollableList({required List list}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var novel in list) DisplayHomeNovelTile(displayNovel: novel)
      ],
    ),
  );
}
