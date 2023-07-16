import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/chapter.dart';

class ChapterTile extends StatelessWidget {
  final Chapter chapter;
  final int index;
  const ChapterTile({
    Key? key,
    required this.chapter,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child: Text(
              chapter.name.trim(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const Icon(Icons.arrow_right),
        ],
      ),
    );
  }
}
