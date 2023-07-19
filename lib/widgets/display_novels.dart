import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/search_display_novel.dart';
import 'package:novel_audiobook_version/widgets/main_display_tile.dart';

class DisplayNovels extends StatelessWidget {
  const DisplayNovels({
    super.key,
    required this.title,
    required this.novels,
  });

  final String title;
  final List<MainDisplayNovel> novels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [for (var novel in novels) MainDisplayTile(novel: novel)],
          ),
        ),
      ],
    );
  }
}
