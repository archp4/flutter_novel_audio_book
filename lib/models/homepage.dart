// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:novel_audiobook_version/models/popular_novels.dart';
import 'package:novel_audiobook_version/models/search_display_novel.dart';

class HomepageData {
  final List<List<MainDisplayNovel>> listOfNovels;
  final List<PopularNovels> listPopularNovel;
  HomepageData({
    required this.listOfNovels,
    required this.listPopularNovel,
  });
}
