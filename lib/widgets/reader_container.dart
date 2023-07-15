import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';
import 'package:novel_audiobook_version/models/reader_chapter.dart';

class ReaderContainer extends StatelessWidget {
  const ReaderContainer({
    super.key,
    required this.isLoaded,
    required this.readerChapter,
  });

  final bool isLoaded;
  final ReaderChapter readerChapter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ConstantValue.defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            isLoaded
                ? Text(
                    readerChapter.data,
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
    );
  }
}
