// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:novel_audiobook_version/models/display_novel.dart';
import 'package:novel_audiobook_version/models/novel_detail.dart';
import 'package:novel_audiobook_version/models/reader_chapter.dart';
import 'package:novel_audiobook_version/models/search_display_novel.dart';

class DioHome {
  static const urlX = 'http://127.0.0.1:8000';
  static var novel_details = '/novel_detail';
  static var lastest_chapters = '/new_update';
  static var popular_novel = '/pop_novel';
  static var searchUrl = '/search';
  static var readerChapter = '/chapter';

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

  static Future<List<SearchDisplayNovel>?> searchNovel(
      {required String url}) async {
    Response response = await dio.get('$urlX$searchUrl?query=$url');
    if (response.statusCode == 200) {
      var tempList = <SearchDisplayNovel>[];

      for (var element in response.data) {
        tempList.add(SearchDisplayNovel.fromMap(element));
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
}
