import 'package:flutter/material.dart';

class SettingDrawers extends StatelessWidget {
  const SettingDrawers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text("Fonts"),
        Wrap(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Lato'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Roboto'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Noto Sans'),
            ),
          ],
        ),
      ],
    );
  }
}
