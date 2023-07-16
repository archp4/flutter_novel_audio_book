import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/novel_detail.dart';

class NovelDetailCard extends StatelessWidget {
  const NovelDetailCard({
    super.key,
    required this.novelDetail,
  });

  final NovelDetail? novelDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          height: 200,
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Image.network(
              novelDetail!.imgSrc,
              fit: BoxFit.cover,
              errorBuilder: (_, object, error) =>
                  Container(color: Colors.amber),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  novelDetail!.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                Text(
                  novelDetail!.descrption,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.justify,

                  // overflow: TextOverflow.ellipsis,
                  // softWrap: true,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
