// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:novel_audiobook_version/models/chapter.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/novel_detail.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/views/reader_chapter.dart';

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
  bool showAll = false;

  getData() async {
    final dio = DioHome();
    novelDetail = await dio.requestNovelDetail(url: widget.novelURL);
    if (novelDetail != null) {
      chapterList = novelDetail!.chapterList.reversed.toList();
      initList = chapterList;
      setState(() => isLoaded = true);
    }
  }

  int getLength() {
    if (chapterList!.length < 10) {
      return chapterList!.length;
    }
    return 10;
  }

  getIndex(int index) {
    if (isDescending) {
      return initList!.length - index - 1;
    }

    return index;
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
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(left: ConstantValue.defaultPadding),
            child: Icon(Icons.arrow_back_ios),
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
                      itemCount: showAll ? chapterList!.length : getLength(),
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
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showAll = !showAll;
                          });
                        },
                        child: const Text('Show All'),
                      ),
                    ),
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

class ChapterTile extends StatelessWidget {
  final Chapter chapter;
  final int index;
  const ChapterTile({
    Key? key,
    required this.chapter,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(chapter.name), const Icon(Icons.arrow_right)],
      ),
    );
  }
}
