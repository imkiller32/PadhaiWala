import 'package:flutter/material.dart';
import 'package:iitism2k16/utils.dart';
import 'package:iitism2k16/utils/module.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ContactUs'),
      ),
      body: ContactPage(),
    );
  }
}

class ContactPage extends StatelessWidget {
  final email = 'iitism2k16@gmail.com';
  final subject = 'Re:PadhaiWala v1.1.3';
  final body = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Social',
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              FlatButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Icon(MdiIcons.googleChrome, color: Colors.orange),
                      Text(
                        '   Website',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: (additionalSettings.getTheme() == true)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  openUrl('https://www.iitism2k16.webnode.com', 'iitism2k16');
                },
              ),
              Divider(
                height: 3.0,
              ),
              FlatButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Icon(MdiIcons.facebook, color: Colors.blueAccent),
                      Text(
                        '   Facebook',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: (additionalSettings.getTheme() == true)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  openUrl('https://www.facebook.com/thepadhaiwala', 'iitism2k16');
                },
              ),
              Divider(
                height: 3.0,
              ),
              FlatButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Icon(MdiIcons.instagram, color: Colors.purple),
                      Text(
                        '   Instagram',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: (additionalSettings.getTheme() == true)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  openUrl('https://www.instagram.com/iitism2k16', 'iitism2k16');
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
              ),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              FlatButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Icon(MdiIcons.gmail, color: Colors.redAccent),
                      Text(
                        '   Email Us',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: (additionalSettings.getTheme() == true)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  openUrl('mailto:$email?subject=$subject&body=$body', 'Email');
                },
              ),
              Divider(
                height: 3.0,
              ),
              FlatButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.green),
                      Text(
                        '   Location',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: (additionalSettings.getTheme() == true)
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  openUrl('https://goo.gl/maps/2jQQVNLTdK82', 'iitism2k16');
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 35.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'We are always here for you !',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
