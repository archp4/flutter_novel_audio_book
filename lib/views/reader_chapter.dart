import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/chapter.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/page_navigatior.dart';
import 'package:novel_audiobook_version/models/reader_chapter.dart';
import 'package:novel_audiobook_version/models/type_of_fonts.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/utilities/open_drawer.dart';
import 'package:novel_audiobook_version/widgets/audio_listener.dart';
import 'package:novel_audiobook_version/widgets/setting_drawer.dart';
import 'package:novel_audiobook_version/widgets/reader_bar.dart';
import 'package:novel_audiobook_version/widgets/reader_container.dart';

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
  bool isSettings = false;
  TypeOfFonts fontType = TypeOfFonts.defaultMain;
  int fontSize = 12;

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

  List<Widget> childrenListTile() {
    return List.generate(widget.chapterList.length, (index) {
      return ListTile(
        onTap: () {
          if (selectIndex != null) setState(() => selectIndex = index);
          // closing drawer after selcting chapter
          openDrawer(scaffoldKey: scaffoldKey);
        },
        title: Text(widget.chapterList[index].name),
      );
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<Widget> children = childrenListTile();
    return Scaffold(
      key: scaffoldKey,
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
      drawer: Drawer(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListView(children: children),
              ),
              if (isSettings) const SettingDrawers(),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              ReaderContainer(
                isLoaded: isLoaded,
                fontSize: fontSize,
                typeOfFonts: fontType,
                readerChapter: readerChapter ??
                    ReaderChapter(
                      name: "",
                      data: "data",
                    ),
              ),
              Positioned(
                bottom: 0,
                height: ConstantValue.defaultPadding * 3,
                child: ReaderBar(
                  chapterList: widget.chapterList,
                  selectIndex: selectIndex!,
                  onAudioBook: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Currently Is Disable By Devloperment"),
                      ),
                    );
                    // await showDialog(
                    //   context: context,
                    //   builder: (_) => AudioBookDialog(
                    //     text: readerChapter!.data,
                    //     imageURL: widget.imageURL,
                    //     title: readerChapter!.name,
                    //   ),
                    // );
                  },
                  onChapterList: () {
                    if (isSettings) {
                      setState(() => isSettings = false);
                    }
                    openDrawer(scaffoldKey: scaffoldKey);
                  },
                  onSettings: () {
                    if (!isSettings) {
                      setState(() => isSettings = true);
                    }
                    openDrawer(scaffoldKey: scaffoldKey);
                  },
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
