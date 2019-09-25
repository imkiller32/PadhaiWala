import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

Future<bool> getSharedTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool theme = prefs.getBool('DarkTheme') ?? false;
  return theme;
}

Future<bool> getPdfSharedTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool pdfShared = prefs.getBool('PdfTheme') ?? false;
  return pdfShared;
}

Future<Null> changeShared(theme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('DarkTheme', theme);
}

Future<Null> changePdfShared(theme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('PdfTheme', theme);
}

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  bool _pdfTheme;
  Future<Null> init() async {
    _themeData =
        (await getSharedTheme() == true) ? ThemeData.dark() : ThemeData.light();

    _pdfTheme = (await getPdfSharedTheme() == true) ? true : false;
    notifyListeners();
  }

  ThemeChanger() {
    init();
  }

  getTheme() => _themeData;
  setTheme(ThemeData theme) async {
    _themeData = theme;
    await changeShared(theme == ThemeData.dark());
    notifyListeners();
  }

  getPdfTheme() => _pdfTheme;
  setPdfTheme(bool theme) async {
    _pdfTheme = theme;
    await changePdfShared(_pdfTheme);
    notifyListeners();
  }
}
