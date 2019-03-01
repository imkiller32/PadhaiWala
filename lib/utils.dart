import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:system_setting/system_setting.dart';

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

void jumpCard(String value, var notes, context) {
  var email = 'iitism2k16@gmail.com';
  var subject = 'Re:Report regarding ' + notes['name'];
  var body = "";
  if (value == 'Report')
    openUrl('mailto:$email?subject=$subject&body=$body', 'Email');
  else if (value == 'Share')
    showDes(notes['name']);
  else if (value == 'Download') openUrl(notes['link'], notes['name']);
}

void internetDesc(BuildContext context, String status) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(status),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 2),
  ));
}

showInternetDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark(),
          child: new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            content: Container(
              width: double.infinity,
              height: 160,
              child: Column(
                children: <Widget>[
                  Text(
                    'Your internet is acting up!\nCheck connection',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'SETTINGS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ),
                    onPressed: () {
                      SystemSetting.goto(SettingTarget.WIFI);
                      Navigator.of(context).pop(true);
                    },
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'CANCEL',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.3,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ),
            // actions: <Widget>[
            //   FlatButton(
            //     child: new Text("CANCEL"),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ],
          ),
        );
      });
}

showMyDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: Text(
            'Message Here',
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
}

Widget stackBehindDismiss() {
  return Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 20.0),
    color: Colors.white,
    child: Icon(
      Icons.delete,
      color: Colors.red,
      size: 40,
    ),
  );
}

void showOptions(notes, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return SingleChildScrollView(
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text(
            notes['name'].toString().toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: Container(
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: notes['image'],
                  width: 150.0,
                  height: 150.0,
                  placeholder: (context, url) => CircularProgressIndicator(
                        strokeWidth: 3.0,
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                ),
                Text(
                  "Description: " + notes['description'],
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                ),
                Text(
                  "Tags : " + notes['date'],
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("View"),
              onPressed: () {
                openUrl(notes['link'], notes['name']);
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
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

Future windowUrl(link, value, context) async {
  if (await url_launcher.canLaunch(link)) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => WebviewScaffold(
              initialChild: Center(
                child: CircularProgressIndicator(),
              ),
              withZoom: true,
              scrollBar: true,
              url: link,
              withJavascript: true,
              appBar: AppBar(
                title: Text(value),
              ),
            )));
    //showDes("Can be");
  } else {
    showDes("NotPossible");
  }
}

void downloadBar(String link, context, String id) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
          title: Text('Downloading...'),
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Text(" %"),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context, 'Cancel'),
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context, 'OK'),
            ),
          ],
        ),
  ).then<String>((returnVal) {
    if (returnVal != null) {
      showName(returnVal);
    }
  });
}
/*
Future<void> Downloadbar(String link, context, String id) async {
  Dio dio = Dio();
  var progress = "0";
  try {
    var dir = await getApplicationDocumentsDirectory();
    await dio.download(link, "${dir.path}/" + id + ".pdf",
        onProgress: (rec, total) {
      print("Rec: $rec , Total: $total");
      progress = ((rec ~/ total) * 100).toString();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Downloading...'),
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(progress + " %"),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context, 'OK'),
                ),
              ],
            ),
      ).then<String>((returnVal) {
        if (returnVal != null) {
          showName(returnVal);
        }
      });
    });
  } catch (e) {
    print(e);
  }
}*/
