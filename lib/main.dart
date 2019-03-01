import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'dart:io';
import 'utils.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'search.dart';
import 'module.dart';
import 'share.dart';
import 'contact_us.dart';
import 'help.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  ConnectivityResult initialNetworkState = ConnectivityResult.none;
  var networkStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  final String url = "http://liveism.xyz/fetch.php";
  final String playStoreLink =
      "https://play.google.com/store/apps/details?id=com.webnode.iitism2k16.www.iitism2k16";
  final String upload = "https://liveism.xyz/upload.php";
  AnimationController _controller;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int selectedBar = 1;
  static const List<IconData> icons = const [
    MdiIcons.googlePlay,
    Icons.share,
    Icons.cloud_upload
  ];
  List data;
  List<double> progress = [];
  Module module;
  @override
  void initState() {
    module = Module();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (networkStatus == 'Unknown') {
        initialNetworkState = result;
        if (initialNetworkState == ConnectivityResult.none) {
          showInternetDialog(context);
        }
        networkStatus = 'Known1';
      }
      connectionStatus = result;
      if (connectionStatus == ConnectivityResult.none) {
        showDes('No Connection');
      }
      if (result == ConnectivityResult.wifi) {
        //internetDesc(context,'Wifi Network detected');
        showDes('Wifi Network detected');
      }
      if (result == ConnectivityResult.mobile) {
        //internetDesc(context,'Mobile Network detected');
        showDes('Mobile Network Detected');
      }
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        if (networkStatus == 'Known1') {
          onRefreshChange();
          networkStatus = 'Known2';
        }
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<Null> onRefreshChange() async {
    if (ConnectivityResult.none == connectionStatus) {
      showInternetDialog(context);
    } else {
      //networkStatus = 'Known1';
      refreshKey.currentState?.show();
      await Future.delayed(const Duration(milliseconds: 2000));
      setState(() {
        this.getData();
      });
      return null;
    }
  }

  void navigationJump(int index) {
    setState(() {
      selectedBar = index;
      jump("ContactUs");
    });
  }

  void jump(String value) {
    if (value == 'ContactUs')
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactUs()),
      );
    else if (value == 'Help')
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Help()),
      );
    else if (value == 'RateUs') openUrl(playStoreLink, 'RateUs');
  }

  Future<void> check(String link, String id, int index) async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    String loc = "${dir.path}/" + id + ".pdf";
    showName(loc);
    print(loc);

    void test() async {
      final file = File(loc);
      //String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      DateTime t = await file.lastModified();
      print(t);
      // await OpenFile.open(loc);
      windowUrl(loc, 'File', context);
    }

    await dio.download(link, loc, onProgress: (rec, total) {
      setState(() {
        progress[index] = (rec / total);
      });
    }).whenComplete(test);
    showName(loc);
    // try {
    //   openUrl(loc, id);
    // } catch (e) {
    //   showName('error->' + e);
    // }
  }

  // Future<void> onPressedLove(int index) {
  //   setState(() {
  //     if (love[index] == Icons.favorite_border) {
  //       love[index] == Icons.favorite;
  //     } else {
  //       love[index] == Icons.favorite_border;
  //     }
  //   });
  // }

  Future<String> getData() async {
    //Future.delayed(Duration.zero, () => showMyDialog(context));

    data = await module.getJsonData(url);
    int len = data.length;
    setState(() {
      for (int i = 0; i < len; i++) {
        progress.add(0);
        //love.add(Icons.favorite_border);
      }
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
                    "padhaiWala",
                    style: TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                  Text(
                    "#Be_Updated",
                    style:
                        TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(data));
            },
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.contacts),
                      Text('  Contact Us'),
                    ],
                  ),
                  value: 'ContactUs',
                ),
                PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.help),
                      Text('  Help'),
                    ],
                  ),
                  value: 'Help',
                ),
                PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(MdiIcons.googlePlay),
                      Text('  Rate Us'),
                    ],
                  ),
                  value: 'RateUs',
                ),
              ];
            },
            onSelected: jump,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigationJump,
        //fixedColor: Colors.black,

        currentIndex: selectedBar,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), title: Text('Bookmarks')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Me')),

          // BottomNavigationBarItem(
          //     icon: Icon(Icons.school), title: Text('Bookmark')),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 60.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            padding: EdgeInsets.all(4.0),
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                mini: false,
                backgroundColor: Colors.black,
                child: new Icon(
                  icons[index],
                  color: Colors.white,
                ),
                onPressed: () {
                  if (index == 0) {
                    openUrl(playStoreLink, 'RateUs');
                  } else if (index == 1) {
                    onShareTap(context, playStoreLink);
                  } else {
                    openUrl(upload, 'upload');
                    //windowUrl(upload, context);
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            new FloatingActionButton(
              heroTag: null,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform: new Matrix4.rotationZ(
                        _controller.value * 0.5 * math.pi),
                    alignment: FractionalOffset.center,
                    child: new Icon(
                        _controller.isDismissed ? Icons.add : Icons.close),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   foregroundColor: Colors.white,
      //   onPressed: () {
      //     onShareTap(context, playStoreLink);
      //     // openUrl(playStoreLink, 'RateUs');
      //   },
      //   //highlightElevation: 10,
      //   child: Icon(Icons.share),
      //   // heroTag: "demoValue",
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.menu),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.search),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 4.0,
      //   elevation: 10.0,
      //   color: Colors.white,
      // ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: onRefreshChange,

        //enablePullUp: true,
        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              resizeDuration: Duration(milliseconds: 1000),
              key: ObjectKey(data[index]['id']),
              onDismissed: (direction) {
                var toDelete = data.elementAt(index);
                setState(() {
                  data.removeAt(index);
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                  content:
                      Text(data[index]['name'].toUpperCase() + ' Deleted '),
                  backgroundColor: Colors.black,
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.blue,
                    onPressed: () {
                      Timer(Duration(seconds: 1), () {
                        setState(() {
                          data.insert(index, toDelete);
                        });
                      });
                    },
                  ),
                ));
              },
              background: stackBehindDismiss(),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          openUrl(data[index]['link'], data[index]['name']);
                        },
                        onDoubleTap: () {
                          showDes(data[index]['name']);
                        },
                        onLongPress: () {
                          // showDes(data[index]['description']);
                          showOptions(data[index], context);
                        },
                        child: Card(
                          elevation: 7.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 10.0,
                                          left: 15.0,
                                          right: 10.0,
                                          bottom: 5.0),
                                      child: CachedNetworkImage(
                                        imageUrl: data[index]['image'],
                                        width: 100.0,
                                        height: 100.0,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3.0, right: 10.0),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10.0),
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
                                            margin: const EdgeInsets.only(
                                                right: 10.0, top: 10.0),
                                            child: Text(
                                              data[index]['description'],
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 10.0, top: 7.0),
                                            child: Text(
                                              "Uploaded on : " +
                                                  data[index]['date'],
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
                                    PopupMenuButton(
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.report),
                                                Text(
                                                  '  Report',
                                                ),
                                              ],
                                            ),
                                            value: 'Report',
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(MdiIcons.share),
                                                Text('  Share'),
                                              ],
                                            ),
                                            value: 'Share',
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(MdiIcons.download),
                                                Text('  Download'),
                                              ],
                                            ),
                                            value: 'Download',
                                          ),
                                        ];
                                      },
                                      onSelected: (value) {
                                        jumpCard(value, data[index], context);
                                      },
                                    ),
                                  ],
                                ),
                                //Padding(padding: const EdgeInsets.all(9.0)),
                                ButtonTheme.bar(
                                  child: ButtonBar(
                                    children: <Widget>[
                                      // FlatButton(
                                      //   child: Text('View'),
                                      //   onPressed: () {
                                      //     openUrl(data[index]['link'],
                                      //         data[index]['name']);
                                      //   },
                                      // ),

                                      // FlatButton.icon(
                                      //   icon: Icon(love[index]),
                                      //   onPressed: () {
                                      //     onPressedLove(index);
                                      //   },
                                      //   label: Column(
                                      //     children: <Widget>[],
                                      //   ),
                                      // ),
//
                                      FlatButton(
                                        child: Text('Download'),
                                        onPressed: () {
                                          showDes('Added Soon');
                                          // check(data[index]['link'],
                                          //     data[index]['id'], index);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // LinearProgressIndicator(
                                //     value: (progress[index] == null)
                                //         ? 0
                                //         : progress[index]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
