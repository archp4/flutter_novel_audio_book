import 'package:flutter/material.dart';

openDrawer({required GlobalKey<ScaffoldState> scaffoldKey}) {
  // create fuction due to repeat use

  if (scaffoldKey.currentState!.isDrawerOpen) {
    scaffoldKey.currentState!.closeDrawer();
  } else {
    scaffoldKey.currentState!.openDrawer();
  }
}
