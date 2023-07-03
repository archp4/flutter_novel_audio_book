// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';

import 'package:novel_audiobook_version/models/search_display_novel.dart';
import 'package:novel_audiobook_version/views/novel_details.dart';

class MainDisplayTile extends StatelessWidget {
  final MainDisplayNovel novel;

  const MainDisplayTile({Key? key, required this.novel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PageNavigation.to(context, NovelDetailView(novelURL: novel.href));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 150,
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              height: 200,
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.network(
                  novel.imgSrc,
                  fit: BoxFit.cover,
                  errorBuilder: (_, object, error) =>
                      Container(color: Colors.amber),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              novel.name,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.left,
              maxLines: 2,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                RatingBarIndicator(
                  rating: toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 12,
                  direction: Axis.horizontal,
                ),
                Text(
                  " (${novel.bookRating})",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              novel.lastChapterTime,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  double toDouble() {
    try {
      return double.parse(novel.bookRating);
    } catch (e) {
      debugPrint(e.toString());
    }
    return 0;
  }
}
