// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/views/novel_details.dart';
import '../models/search_display_novel.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<MainDisplayNovel>? tempList;
  bool isSearchResultDone = false;
  bool is404 = false;
  bool isSearchInitited = true;

  @override
  void initState() {
    super.initState();
  }

  getSearchResult(value) async {
    tempList = await DioHome.searchNovel(url: value);
    setState(
      () {
        if (tempList != null) {
          is404 = false;
          isSearchResultDone = true;
        }
        if (isSearchResultDone) {
          is404 = true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: ConstantValue.defaultPadding,
          ),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    getSearchResult(value);
                  },
                  onFieldSubmitted: (value) {
                    getSearchResult(value);
                  },
                ),
                SearchBoday(
                  resultList: tempList ?? [],
                  isSearchResultDone: isSearchResultDone,
                  is404: is404,
                  isSearchInitited: isSearchInitited,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBoday extends StatelessWidget {
  final List<MainDisplayNovel> resultList;
  final bool isSearchResultDone;
  final bool isSearchInitited;
  final bool is404;

  const SearchBoday({
    Key? key,
    required this.resultList,
    required this.isSearchResultDone,
    required this.is404,
    required this.isSearchInitited,
  }) : super(key: key);

  bool getSearch() {
    if (resultList.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool showListed = getSearch();
    return showListed
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: resultList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => PageNavigation.to(
                  context,
                  NovelDetailView(novelURL: resultList[index].href),
                ),
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: ConstantValue.defaultPadding * .4,
                      vertical: ConstantValue.defaultPadding * .8,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Text(resultList[index].name)
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Image.network(
                    //       resultList[index].imgSrc,
                    //       height: 140,
                    //     ),
                    //     const SizedBox(width: ConstantValue.defaultPadding),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Flexible(
                    //           child: Text(resultList[index].name),
                    //         ),
                    //         const SizedBox(
                    //           height: ConstantValue.defaultPadding * .5,
                    //         ),
                    //         Row(
                    //           children: [
                    //             for (var tag in resultList[index].tags)
                    //               TagTile(tag: tag)
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    ),
              );
            },
          )
        : Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 100,
            child: is404
                ? const Text("Novel not founded")
                : isSearchInitited
                    ? const Text("Serach for novel here")
                    : const Text("data"),
          );
  }
}

class TagTile extends StatelessWidget {
  const TagTile({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(
          ConstantValue.defaultPadding,
        ),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
