// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:novel_audiobook_version/models/display_novel.dart';
import 'package:novel_audiobook_version/models/homepage.dart';
import 'package:novel_audiobook_version/models/novel_detail.dart';
import 'package:novel_audiobook_version/models/popular_novels.dart';
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

  late Dio dio;
  init() {
    dio = Dio();
  }

  Future<NovelDetail?> requestNovelDetail({required String url}) async {
    fix();
    Response response;
    response = await dio.get('$urlX$novel_details?url=$url');
    if (response.statusCode == 200) {
      var temp = NovelDetail.fromMap(response.data);
      return temp;
    }
    return null;
  }

  Future<List<DisplayNovel>?> requestLastestUpdate() async {
    fix();
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

  Future<List<DisplayNovel>?> requestPopularNovel() async {
    fix();
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

  Future<List<MainDisplayNovel>?> searchNovel({required String url}) async {
    fix();
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

  Future<ReaderChapter?> getReaderChpater({required String url}) async {
    fix();
    Response response;
    response = await dio.get('$urlX$readerChapter?url=$url');
    if (response.statusCode == 200) {
      var temp = ReaderChapter.fromMap(response.data);
      return temp;
    }
    return null;
  }

  Future<HomepageData?> requestHomePageDetails() async {
    fix();

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
      var listPopularNovel = <PopularNovels>[];
      for (var novel in response.data['popular']) {
        PopularNovels temp = PopularNovels.fromMap(novel);
        listPopularNovel.add(temp);
      }
      return HomepageData(
        listOfNovels: listOfList,
        listPopularNovel: listPopularNovel,
      );
    }
    return null;
  }

  fix() {
    init();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  void dispose() {
    dio.close();
  }
}
