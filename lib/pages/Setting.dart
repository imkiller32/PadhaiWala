import 'package:flutter/material.dart';
import 'package:iitism2k16/utils/module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

Future<Null> changeShared(pdftheme) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('PdfTheme', pdftheme);
}

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool darkTheme = additionalSettings.getTheme();
  bool pdfTheme = additionalSettings.getPdfTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Options',
                    style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  ListTile(
                    title: Text(
                      '   Dark Theme',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Switch(
                      value: false,
                      onChanged: null,
                      // onChanged: (value) {
                      //   setState(() {
                      //     darkTheme = false;
                      //     showDes('added soon');
                      //     additionalSettings.setTheme(darkTheme);
                      //   });
                      // },
                    ),
                  ),
                  Divider(
                    height: 3.0,
                  ),
                  ListTile(
                    title: Text(
                      '   Night mode for pdf',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Switch(
                      value: pdfTheme,
                      onChanged: (value) {
                        changeShared(value);
                        setState(() {
                          additionalSettings.setPdf(value);
                          pdfTheme = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
