import 'package:flutter/material.dart';
import 'package:iitism2k16/themes/theme.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    ThemeData data = _themeChanger.getTheme();
    bool pdfTheme = _themeChanger.getPdfTheme();
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
                      style: TextStyle(
                          color: (_themeChanger.getTheme() == ThemeData.dark())
                              ? Colors.white
                              : Colors.black),
                    ),
                    trailing: Switch(
                      value: data == ThemeData.dark(),
                      onChanged: (value) async {
                        if (value == true)
                          _themeChanger.setTheme(ThemeData.dark());
                        else
                          _themeChanger.setTheme(ThemeData.light());
                      },
                    ),
                  ),
                  Divider(
                    height: 3.0,
                  ),
                  ListTile(
                    title: Text(
                      '   Night mode for pdf',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: (_themeChanger.getTheme() == ThemeData.dark())
                              ? Colors.white
                              : Colors.black),
                    ),
                    trailing: Switch(
                      value: pdfTheme,
                      onChanged: (value) async {
                        _themeChanger.setPdfTheme(value);
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
