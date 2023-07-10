import 'package:flutter/material.dart';

double toDouble(String rating) {
  try {
    return double.parse(rating);
  } catch (e) {
    debugPrint(e.toString());
  }
  return 0;
}
