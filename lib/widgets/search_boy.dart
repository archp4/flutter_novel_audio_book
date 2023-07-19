import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/models/search_display_novel.dart';
import 'package:novel_audiobook_version/views/novel_details.dart';

class SearchBody extends StatelessWidget {
  final List<MainDisplayNovel> resultList;
  final bool isSearchResultDone;
  final bool isSearchInitited;
  final bool is404;

  const SearchBody({
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
