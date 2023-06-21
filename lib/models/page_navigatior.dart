import 'package:flutter/material.dart';

class PageNavigation {
  static to(context, widget) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  static pageReplacement(context, widget) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  static pop(context) {
    return Navigator.pop(context);
  }
}
