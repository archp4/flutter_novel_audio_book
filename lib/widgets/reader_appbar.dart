// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ReaderAppbar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onSpeak;
  final VoidCallback onPause;
  final String title;
  final bool isPlaying;
  final BuildContext context;
  @override
  Size get preferredSize => const Size.fromHeight(60);
  const ReaderAppbar({
    Key? key,
    required this.onSpeak,
    required this.onPause,
    required this.title,
    required this.isPlaying,
    required this.context,
  }) : super(key: key);

  @override
  State<ReaderAppbar> createState() => _ReaderAppbarState();
}

class _ReaderAppbarState extends State<ReaderAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        if (!widget.isPlaying)
          IconButton(
            onPressed: () => widget.onSpeak(),
            icon: const Icon(Icons.mic_outlined),
          ),
        if (widget.isPlaying)
          IconButton(
            onPressed: () => widget.onPause(),
            icon: const Icon(Icons.pause),
          ),
      ],
    );
  }
}
