import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

Future windowUrl(link, context) async {
  if (await url_launcher.canLaunch(link)) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => WebviewScaffold(
              initialChild: Center(
                child: CircularProgressIndicator(),
              ),
              url: link,
              withJavascript: true,
              appBar: AppBar(
                title: Text(link),
              ),
            )));
    //showDes("Can be");
  } else {
    showDes("NotPossible");
  }
}

void Downloadbar(String link, context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
          title: Text('Downloader'),
          content: Text('Percentage'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () =>Navigator.pop(context,'Cancel'),
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: ()=>Navigator.pop(context,'OK') ,
            ),
          ],
        ),
  ).then<String>((returnVal){
    if(returnVal!=null){
      showName(returnVal);
    }
  });
}
