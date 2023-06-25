// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/display_novel.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/models/search_display_novel.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/views/search_view.dart';
import 'package:novel_audiobook_version/widgets/display_home_novel_tile.dart';
import 'package:novel_audiobook_version/widgets/main_display_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<DisplayNovel>? popularList;
  List<List<MainDisplayNovel>>? list;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    list = await DioHome.requestHomePageDetails();
    if (list != null) {
      setState(() => isLoading = false);
    }
  }

  String getGreeting() {
    return "Good Morning,";
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
            top: ConstantValue.defaultPadding,
          ),
          decoration: const BoxDecoration(),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Text(
                      getGreeting(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      "User",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      'Popular Novels',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    DisplayNovels(title: 'Lastest Updates', novels: list![0]),
                    DisplayNovels(title: 'Completed', novels: list![1]),
                    DisplayNovels(title: 'Romance', novels: list![2]),
                    DisplayNovels(title: 'Fantasy', novels: list![3]),
                    DisplayNovels(title: 'Drama', novels: list![4]),
                    DisplayNovels(title: 'Action', novels: list![5]),
                    // getScrollableList(list: popularList!),
                  ],
                ),
        ),
      ),
    );
  }
}

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

Widget getScrollableList({required List list}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var novel in list) DisplayHomeNovelTile(displayNovel: novel)
      ],
    ),
  );
}
