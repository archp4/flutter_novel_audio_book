import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:novel_audiobook_version/utilities/to_double.dart';

class BookRating extends StatelessWidget {
  final String bookRating;
  const BookRating({super.key, required this.bookRating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: toDouble(bookRating),
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 12,
          direction: Axis.horizontal,
        ),
        Text(
          bookRating,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
