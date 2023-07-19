import 'package:flutter/material.dart';
import 'package:novel_audiobook_version/models/const_value.dart';

class TagTile extends StatelessWidget {
  const TagTile({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(
          ConstantValue.defaultPadding,
        ),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
