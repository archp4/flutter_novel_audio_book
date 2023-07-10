import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/popular_novels.dart';
import 'package:novel_audiobook_version/widgets/carousel_tile.dart';

class PopularCarouselSlider extends StatelessWidget {
  const PopularCarouselSlider({super.key, required this.novels});

  final List<PopularNovels> novels;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(
        novels.length, (index) => CarouselTile(popularNovel: novels[index]));
    return CarouselSlider(
      items: children,
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        initialPage: 1,
      ),
    );
  }
}
