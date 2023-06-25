// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:novel_audiobook_version/models/display_novel.dart';
import 'package:novel_audiobook_version/models/novel_detail.dart';
import 'package:novel_audiobook_version/models/reader_chapter.dart';
import 'package:novel_audiobook_version/models/search_display_novel.dart';

class DioHome {
  static const urlX = 'https://novel_python_api-1-h3046701.deta.app';
  static var novel_details = '/novel_detail';
  static var lastest_chapters = '/new_update';
  static var popular_novel = '/pop_novel';
  static var searchUrl = '/search';
  static var readerChapter = '/chapter';
  static var homepage = '/homepage';

  static final dio = Dio();

  static Future<NovelDetail?> requestNovelDetail({required String url}) async {
    Response response;
    response = await dio.get('$urlX$novel_details?url=$url');
    if (response.statusCode == 200) {
      var temp = NovelDetail.fromMap(response.data);
      return temp;
    }
    return null;
  }

  static Future<List<DisplayNovel>?> requestLastestUpdate() async {
    Response response = await dio.get('$urlX$lastest_chapters');
    if (response.statusCode == 200) {
      var tempList = <DisplayNovel>[];
      for (var element in response.data) {
        tempList.add(DisplayNovel.fromMap(element));
      }
      return tempList;
    }
    return null;
  }

  static Future<List<DisplayNovel>?> requestPopularNovel() async {
    Response response = await dio.get('$urlX$popular_novel');
    if (response.statusCode == 200) {
      var tempList = <DisplayNovel>[];

      for (var element in response.data['data']) {
        tempList.add(DisplayNovel.fromMap(element));
      }
      return tempList;
    }
    return null;
  }

  static Future<List<MainDisplayNovel>?> searchNovel(
      {required String url}) async {
    Response response = await dio.get('$urlX$searchUrl?query=$url');
    if (response.statusCode == 200) {
      var tempList = <MainDisplayNovel>[];

      for (var element in response.data) {
        tempList.add(MainDisplayNovel.fromMap(element));
      }
      return tempList;
    }
    return null;
  }

  static Future<ReaderChapter?> getReaderChpater({required String url}) async {
    Response response;
    response = await dio.get('$urlX$readerChapter?url=$url');
    if (response.statusCode == 200) {
      var temp = ReaderChapter.fromMap(response.data);
      return temp;
    }
    return null;
  }

  static Future<List<List<MainDisplayNovel>>?> requestHomePageDetails() async {
    Response response;
    final url = '$urlX$homepage';
    response = await dio.get(url);
    if (response.statusCode == 200) {
      var listOfList = <List<MainDisplayNovel>>[];
      for (var novelList in response.data['data']) {
        var tempList = <MainDisplayNovel>[];
        for (var novel in novelList) {
          MainDisplayNovel temp = MainDisplayNovel.fromMap(novel);
          tempList.add(temp);
        }
        listOfList.add(tempList);
      }
      return listOfList;
    }
    return null;
  }
}
