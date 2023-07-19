// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/services/dio_home.dart';
import 'package:novel_audiobook_version/widgets/search_boy.dart';
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
    final dio = DioHome();
    tempList = await dio.searchNovel(url: value);
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
                SearchBody(
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
