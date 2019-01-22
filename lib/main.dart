import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = "http://liveism.xyz/fetch.php";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //encode the url
        Uri.encodeFull(url),
        //only accept json
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      print(convertDataToJson);
      data = convertDataToJson;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/iitism.png',
              fit: BoxFit.contain,
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 5.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "iitism2k16",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "#Be_Updated!",
                    style:
                        TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 200.0)),
            PopupMenuButton(
              elevation: 2.0,
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('ContactUs'),
                  ),
                  PopupMenuItem(child: Text('Help')),
                ];
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            data[index]['image'],
                            width: 100.0,
                            height: 100.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 3.0, right: 10.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    data[index]['name']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0,top: 10.0),
                                  child: Text(
                                    data[index]['description'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                /*Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    data[index]['link'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),*/
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0,top:7.0),
                                  child: Text(
                                    "Uploaded on : "+data[index]['date'],
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
