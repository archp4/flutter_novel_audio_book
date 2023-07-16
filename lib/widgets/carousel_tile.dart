import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/models/popular_novels.dart';
import 'package:novel_audiobook_version/views/novel_details.dart';
import 'package:novel_audiobook_version/widgets/book_rating.dart';

class CarouselTile extends StatelessWidget {
  final PopularNovels popularNovel;
  const CarouselTile({super.key, required this.popularNovel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PageNavigation.to(
        context,
        NovelDetailView(novelURL: popularNovel.href),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).highlightColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              child: Image.network(
                popularNovel.imgSrc,
                height: 170,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.white,
                  width: 120,
                  height: 170,
                ),
              ),
            ),
            const SizedBox(
              width: ConstantValue.defaultPadding * .4,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: ConstantValue.defaultPadding * .3),
                  Text(
                    popularNovel.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: ConstantValue.defaultPadding * .5),
                  Text(
                    "Views : ${popularNovel.totalRead}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: ConstantValue.defaultPadding * .2),
                  BookRating(bookRating: popularNovel.bookRating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
