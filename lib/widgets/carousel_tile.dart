import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/popular_novels.dart';
import 'package:novel_audiobook_version/widgets/book_rating.dart';

class CarouselTile extends StatelessWidget {
  final PopularNovels popularNovel;
  const CarouselTile({super.key, required this.popularNovel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Image.network(popularNovel.imgSrc),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(popularNovel.name),
                Text(popularNovel.totalRead),
                BookRating(bookRating: popularNovel.bookRating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
