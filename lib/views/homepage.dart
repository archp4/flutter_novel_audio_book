// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/homepage.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/views/search_view.dart';
import 'package:novel_audiobook_version/widgets/display_novels.dart';
import 'package:novel_audiobook_version/widgets/slider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomepageData? homepage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final dio = DioHome();
    homepage = await dio.requestHomePageDetails();
    if (homepage != null) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Homepage"),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
              onPressed: () => PageNavigation.to(context, const SearchView()),
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(
            left: ConstantValue.defaultPadding,
          ),
          decoration: const BoxDecoration(),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Text(
                      'Popular Novels',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    PopularCarouselSlider(novels: homepage!.listPopularNovel),
                    const SizedBox(height: 16),
                    if (homepage!.listOfNovels[0].isNotEmpty)
                      DisplayNovels(
                        title: 'Lastest Updates',
                        novels: homepage!.listOfNovels[0],
                      ),
                    if (homepage!.listOfNovels[1].isNotEmpty)
                      DisplayNovels(
                        title: 'Completed',
                        novels: homepage!.listOfNovels[1],
                      ),
                    if (homepage!.listOfNovels[2].isNotEmpty)
                      DisplayNovels(
                        title: 'Romance',
                        novels: homepage!.listOfNovels[2],
                      ),
                    if (homepage!.listOfNovels[3].isNotEmpty)
                      DisplayNovels(
                        title: 'Fantasy',
                        novels: homepage!.listOfNovels[3],
                      ),
                    if (homepage!.listOfNovels[4].isNotEmpty)
                      DisplayNovels(
                        title: 'Drama',
                        novels: homepage!.listOfNovels[4],
                      ),
                    if (homepage!.listOfNovels[5].isNotEmpty)
                      DisplayNovels(
                        title: 'Action',
                        novels: homepage!.listOfNovels[5],
                      ),
                    // getScrollableList(list: popularList!),
                  ],
                ),
        ),
      ),
    );
  }
}
