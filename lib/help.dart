import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(Help());

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: HelpPage(),
    );
  }
}

class HelpPage extends StatelessWidget {
  final email = 'iitism2k16@gmail.com';
  final subject = 'FeedBack regarding iitism2k16 1.1.0';
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
                'Legal',
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
                      Icon(MdiIcons.laptopChromebook, color: Colors.black54),
                      Text(
                        '   Privacy Policy',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  windowUrl('https://iitism2k16.webnode.com/privacy-policy/',
                      'PrivacyPolicy', context);
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
                      Icon(Icons.phone, color: Colors.blue),
                      Text(
                        '   Help Centre',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  openUrl('tel:7088774424', 'CallUS');
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
                      Icon(Icons.feedback, color: Colors.grey),
                      Text(
                        '   Feedback',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  openUrl('mailto:$email?subject=$subject&body=$body', 'Email');
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
              ),
              Text(
                'About',
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              Text('iitism2k16'),
              Text('Version:1.1.0'),
            ],
          ),
        ),
      ),
    );
  }
}
