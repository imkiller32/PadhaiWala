import 'dart:async';
import 'dart:core';
import 'dart:typed_data';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:system_setting/system_setting.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

void showDes(String value) {
  Fluttertoast.showToast(
    msg: value.toUpperCase(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 1,
    fontSize: 16.0,
    // backgroundColor: Colors.black,
    // textColor: Colors.white,
  );
}

void jumpCard(String value, var notes, context) {
  var email = 'iitism2k16@gmail.com';
  var subject = 'Re:Report regarding ' + notes['name'];
  var body = "";
  if (value == 'Flag')
    openUrl('mailto:$email?subject=$subject&body=$body', 'Email');
  else if (value == 'Share')
    showDes(notes['name']);
  else if (value == 'Delete') openUrl(notes['link'], notes['name']);
}

void internetDesc(BuildContext context, String status) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(status),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 2),
  ));
}

// Future<void> deleteDownloaded(index, notes, context) async {
//   List<int> value = await checkExistance(notes['id']);
//   if (value == null) return;
//   var dir = await getApplicationDocumentsDirectory();
//   String loc = "${dir.path}/" + notes['id'] + ".pdf";
//   var path = Directory(loc);
//   path.delete(recursive: true);
// }

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
        child: Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            title: Text(
              notes['name'].toString().toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
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
              // FlatButton(
              //   child: new Text("View"),
              //   onPressed: () {
              //     openUrl(notes['link'], notes['name']);
              //     Navigator.of(context).pop();
              //   },
              // ),
              FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
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

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(id) async {
  final path = await _localPath;
  return File('$path/$id.pdf');
}

Future<void> downloadThis(link, id) async {
  HttpClient client = new HttpClient();
  var _downloadData = List<int>();
  var fileSave = await _localFile(id);
  print(fileSave.toString());
  //var fileSave = new File('./logo.png');
  client.getUrl(Uri.parse(link)).then((HttpClientRequest request) {
    return request.close();
  }).then((HttpClientResponse response) {
    response.listen((d) => _downloadData.addAll(d), onDone: () {
      fileSave.writeAsBytes(_downloadData);
      // print(_downloadData.toString());
    });
  });
}

Future<Uint8List> downloadAsBytes(String url) {
  return http.readBytes(url);
}

Future<List<int>> checkExistance(id) async {
  try {
    final file = await _localFile(id);
    List<int> contents;
    contents = await file.readAsBytes();
    return (contents);
  } catch (e) {
    return null;
  }
}

Future<Null> showFile(filePath, pdfTheme) async {
  PdfViewer.loadFile(filePath,
      config: PdfViewerConfig(
          nightMode: pdfTheme,
          swipeHorizontal: true,
          autoSpacing: true,
          forceLandscape: false,
          pageSnap: true,
          pageFling: true));
}

Future<Null> openFile(link, id) async {
  //Uint8List file = await downloadAsBytes(link);
  File path = await _localFile(id);
  List<int> value = await checkExistance(id);
  if (value == null) {
    print("File not present in local storage.");
    await downloadThis(link, id);
  }
  PdfViewer.loadFile(path.path,
      config: PdfViewerConfig(
          nightMode: false,
          swipeHorizontal: true,
          autoSpacing: true,
          forceLandscape: false,
          pageSnap: true,
          pageFling: true));
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
    await url_launcher.launch(link);
  } else {
    showDes("Can not");
  }
  // Completer<WebViewController> _controller = Completer<WebViewController>();
  // if (await url_launcher.canLaunch(link)) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (ctx) => WebView(
  //             initialUrl: link,
  //             javascriptMode: JavascriptMode.unrestricted,
  //             onWebViewCreated: (WebViewController controller) {
  //               _controller.complete(controller);
  //             },
  //           )));
  // } else {
  //   showDes("NotPossible");
  // }
}
