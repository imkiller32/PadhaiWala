import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:fluttertoast/fluttertoast.dart';

void showDes(String value) {
  Fluttertoast.showToast(
    msg: value.toUpperCase(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}

void showName(String value) {
  Fluttertoast.showToast(
    msg: value.toUpperCase(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 1,
    backgroundColor: Colors.white,
    textColor: Colors.black,
  );
}

Future<Null> openUrl(link, name) async {
  if (await url_launcher.canLaunch(link)) {
    await url_launcher.launch(link);
  } else {
    showDes("Can not");
  }
}
