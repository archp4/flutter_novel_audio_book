import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/reader_chapter.dart';
import 'package:novel_audiobook_version/models/type_of_fonts.dart';

class ReaderContainer extends StatelessWidget {
  const ReaderContainer({
    super.key,
    required this.isLoaded,
    required this.readerChapter,
    required this.fontSize,
    required this.typeOfFonts,
  });

  final bool isLoaded;
  final ReaderChapter readerChapter;

  final int fontSize;
  final TypeOfFonts typeOfFonts;
  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(ConstantValue.defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            isLoaded
                ? Text(
                    readerChapter.data,
                    style: style,
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
    );
  }
}
