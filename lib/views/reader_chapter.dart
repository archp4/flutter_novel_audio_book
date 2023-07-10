import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/chapter.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/models/reader_chapter.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/widgets/audio_listener.dart';
import 'package:novel_audiobook_version/widgets/reader_bottom_bar.dart';

class ReaderChapterView extends StatefulWidget {
  final List<Chapter> chapterList;
  final int selectIndex;
  final String imageURL;
  @override
  const ReaderChapterView({
    required this.chapterList,
    required this.selectIndex,
    required this.imageURL,
    super.key,
  });

  @override
  State<ReaderChapterView> createState() => _ReaderChpaterState();
}

class _ReaderChpaterState extends State<ReaderChapterView> {
  int? selectIndex;
  ReaderChapter? readerChapter;
  bool isLoaded = false;

  @override
  void initState() {
    selectIndex = widget.selectIndex;
    getData(url: widget.chapterList[selectIndex!].addressNo);
    super.initState();
  }

  getData({required url}) async {
    final dio = DioHome();
    readerChapter = await dio.getReaderChpater(url: url);
    if (readerChapter != null) {
      setState(() => isLoaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isLoaded ? readerChapter!.name : ""),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => PageNavigation.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: ConstantValue.defaultPadding / 2),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) => AudioBookDialog(
              text: readerChapter!.data,
              imageURL: widget.imageURL,
              title: readerChapter!.name,
            ),
          );
        },
        child: const Icon(Icons.book_online),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Container(),
            Container(),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(ConstantValue.defaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      isLoaded
                          ? Text(
                              readerChapter!.data,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            ),
                      const SizedBox(height: ConstantValue.defaultPadding * 3)
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                height: ConstantValue.defaultPadding * 3,
                child: ReaderBottombar(
                  chapterList: widget.chapterList,
                  selectIndex: selectIndex!,
                  onNext: () async {
                    selectIndex = selectIndex! + 1;
                    setState(() => isLoaded = false);
                    await getData(
                        url: widget.chapterList[selectIndex!].addressNo);
                    setState(() => isLoaded = true);
                  },
                  onPrev: () async {
                    selectIndex = selectIndex! - 1;
                    setState(() => isLoaded = false);
                    await getData(
                        url: widget.chapterList[selectIndex!].addressNo);
                    setState(() => isLoaded = true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
