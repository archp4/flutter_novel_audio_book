// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:novel_audiobook_version/models/chapter.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/novel_detail.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/views/reader_chapter.dart';
import 'package:novel_audiobook_version/widgets/chapter_tile.dart';
import 'package:novel_audiobook_version/widgets/novel_detail_card.dart';

class NovelDetailView extends StatefulWidget {
  final String novelURL;
  const NovelDetailView({
    Key? key,
    required this.novelURL,
  }) : super(key: key);

  @override
  State<NovelDetailView> createState() => _NovelDetailViewState();
}

class _NovelDetailViewState extends State<NovelDetailView> {
  bool isLoaded = false;
  NovelDetail? novelDetail;
  List<Chapter>? initList;
  List<Chapter>? chapterList;
  bool isDescending = false;
  bool showAll = true;
  int length = 0;

  getData() async {
    final dio = DioHome();
    novelDetail = await dio.requestNovelDetail(url: widget.novelURL);
    if (novelDetail != null) {
      chapterList = novelDetail!.chapterList.reversed.toList();
      initList = chapterList;
      length = getLength();
      setState(() => isLoaded = true);
    }
  }

  int getLength() {
    return chapterList!.length;
  }

  getIndex(int index) {
    if (isDescending) {
      return initList!.length - index - 1;
    }

    return index;
  }

  adjustLength() {
    if (length + 100 < getLength()) {
      length = length + 100;
    } else {
      length = getLength();
    }
    if (!showAll) length = 10;
  }

  adjustShowButton() {
    if (length == getLength()) {
      showAll = false;
    } else {
      showAll = true;
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novel Details'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: ConstantValue.defaultPadding),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ),
      body: isLoaded
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: NovelDetailCard(novelDetail: novelDetail),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chapter List',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() => isDescending = !isDescending);
                              if (chapterList != null) {
                                chapterList = chapterList!.reversed.toList();
                              }
                            },
                            icon: const Icon(Icons.swap_vert),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            PageNavigation.to(
                              context,
                              ReaderChapterView(
                                chapterList: initList!,
                                selectIndex: getIndex(index),
                                imageURL: novelDetail!.imgSrc,
                              ),
                            );
                          },
                          child: ChapterTile(
                            chapter: chapterList![index],
                            index: index,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    // Center(
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width - 20,
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         setState(() {});
                    //       },
                    //       child: Text(showAll ? 'Show More' : 'Show Less'),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
