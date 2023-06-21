import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/display_novel.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/views/novel_details.dart';

class DisplayHomeNovelTile extends StatelessWidget {
  final DisplayNovel displayNovel;
  const DisplayHomeNovelTile({super.key, required this.displayNovel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PageNavigation.to(
          context,
          NovelDetailView(
            novelURL: displayNovel.href,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 150,
        height: 280,
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
                  displayNovel.imgSrc,
                  fit: BoxFit.cover,
                  errorBuilder: (_, object, error) =>
                      Container(color: Colors.amber),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              displayNovel.name,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.left,
              maxLines: 2,
            ),
            const SizedBox(height: 5),
            Text(
              displayNovel.lastestChapterTime,
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
}
