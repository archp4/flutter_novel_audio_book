import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/popular_novels.dart';
import 'package:novel_audiobook_version/widgets/carousel_tile.dart';

class PopularCarouselSlider extends StatefulWidget {
  const PopularCarouselSlider({super.key, required this.novels});

  final List<PopularNovels> novels;

  @override
  State<PopularCarouselSlider> createState() => _PopularCarouselSliderState();
}

class _PopularCarouselSliderState extends State<PopularCarouselSlider> {
  int _current = 0;
  final _controller = CarouselControllerImpl();
  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(widget.novels.length,
        (index) => CarouselTile(popularNovel: widget.novels[index]));
    return Column(
      children: [
        CarouselSlider(
          items: children,
          carouselController: _controller,
          options: CarouselOptions(
            height: 170,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.ease,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.novels.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
