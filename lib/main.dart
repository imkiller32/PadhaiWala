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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'search.dart';
import 'module.dart';
import 'share.dart';
import 'contact_us.dart';
import 'help.dart';
import 'setting.dart';
import 'login.dart';

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
  bool pdfTheme = additionalSettings.getPdfTheme();
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
      jump("login");
    });
  }

  void jump(String value) {
    if (value == 'Setting') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Setting()),
      );
      setState(() {
        pdfTheme = additionalSettings.getPdfTheme();
      });
    } else if (value == 'ContactUs')
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactUs()),
      );
    else if (value == 'Help')
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Help()),
      );
    else if (value == 'RateUs')
      openUrl(playStoreLink, 'RateUs');
    else if (value == 'login')
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
  }

  Future<void> viewNotes(String link, String id, int index) async {
    String loc = await downloadNotes(link, id, index);
    showFile(loc, additionalSettings.getPdfTheme());
  }

  Future<String> downloadNotes(String link, String id, int index) async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();

    List<int> value = await checkExistance(id);

    String loc = "${dir.path}/" + id + ".pdf";

    if (value == null) {
      showDes('Initiating...');
      await dio.download(link, loc, onReceiveProgress: (rec, total) {
        setState(() {
          progress[index] = (rec / total);
        });
      });
    }
    return loc;
  }

  // void updateProgress(String id, index) async {
  //   print('object');
  //   List<int> value = await checkExistance(id);
  //   if (value == null) {
  //     setState(() {
  //       progress[index] = 0;
  //     });
  //   }
  // }

  Future<void> deleteDownloaded(index) async {
    var dir = await getApplicationDocumentsDirectory();
    String loc = "${dir.path}/" + data[index]['id'] + ".pdf";
    var path = Directory(loc);
    path.delete(recursive: true);
    setState(() {
      progress[index] = 0;
    });
  }

  showDeleteDialog(BuildContext context, index) {
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
                height: 120,
                child: Column(
                  children: <Widget>[
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
                          'DELETE',
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
                        deleteDownloaded(index);
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
            ),
          );
        });
  }

  void settingModalBottomSheet(context, index, notes) async {
    List<int> value = await checkExistance(notes['id']);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.flag),
                    title: Text('Flag'),
                    onTap: () {
                      jumpCard('Flag', notes, context);
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    }),
                ListTile(
                  leading: Icon(MdiIcons.share),
                  title: Text('Share'),
                  onTap: () {
                    jumpCard('Share', notes, context);
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  },
                ),
                (value != null)
                    ? ListTile(
                        leading: Icon(
                          MdiIcons.delete,
                        ),
                        title: Text('Delete'),
                        onTap: () {
                          deleteDownloaded(index);
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                      )
                    : ListTile(
                        leading: Icon(
                          MdiIcons.download,
                        ),
                        title: Text('Download'),
                        onTap: () {
                          downloadNotes(
                              data[index]['link'], data[index]['id'], index);
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                      ),
              ],
            ),
          );
        });
  }

  void createBottomSheet(index) async {
    settingModalBottomSheet(context, index, data[index]);
  }

  Future<String> getData() async {
    //Future.delayed(Duration.zero, () => showMyDialog(context));

    data = await module.getJsonData(url);
    int len = data.length;
    List<double> copied = [];
    for (int i = 0; i < len; i++) {
      List<int> value = await checkExistance(data[i]['id']);
      if (value == null)
        copied.add(0);
      else
        copied.add(1);
    }

    setState(() {
      for (int i = 0; i < len; i++) {
        progress.add(copied[i]);
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
                    "iitism2k16",
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
                      Icon(Icons.settings),
                      Text('  Settings'),
                    ],
                  ),
                  value: 'Setting',
                ),
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
      body: (data == null)
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitFadingCircle(
                  itemBuilder: (_, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.blue : Colors.black,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  "Loading...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 20,
                  ),
                ),
              ],
            ))
          : RefreshIndicator(
              key: refreshKey,
              onRefresh: onRefreshChange,
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
                        content: Text(
                            data[index]['name'].toUpperCase() + ' Deleted '),
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
                      color: Colors.white,
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                viewNotes(data[index]['link'],
                                    data[index]['id'], index);
                              },
                              onDoubleTap: () {
                                showDes(data[index]['name']);
                              },
                              onLongPress: () {
                                // showDes(data[index]['description']);
                                showOptions(data[index], context);
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 2.0,
                                //color: Colors.white70,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Container(
                                        margin:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Text(
                                          data[index]['name']
                                              .toString()
                                              .toUpperCase(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.only(left: 20),
                                      trailing: IconButton(
                                        tooltip: 'More Actions',
                                        icon: Icon(Icons.more_vert),
                                        onPressed: () {
                                          createBottomSheet(index);
                                          //updateProgress(data[index]['id'], index);
                                          // setState(() {
                                          //   progress[index] = 0;
                                          // });
                                        },
                                      ),
                                    ),
                                    Card(
                                      //color: Colors.white10,
                                      elevation: 0.0,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            // Padding(
                                            //   padding: const EdgeInsets.all(3.0),
                                            // ),
                                            Row(
                                              //mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 0.0,
                                                      left: 15.0,
                                                      right: 10.0,
                                                      bottom: 5.0),
                                                  child: CachedNetworkImage(
                                                    fadeInCurve: Curves.easeIn,
                                                    imageUrl: data[index]
                                                        ['image'],
                                                    width: 100.0,
                                                    height: 100.0,
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0,
                                                          right: 10.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 10.0,
                                                            top: 0.0),
                                                        child: Text(
                                                          data[index]
                                                              ['description'],
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                          ),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            right: 10.0,
                                                            top: 7.0),
                                                        child: Text(
                                                          "Uploaded on : " +
                                                              data[index]
                                                                  ['date'],
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {},
                                          //padding: EdgeInsets.only(left: 15),
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            MdiIcons.commentOutline,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            MdiIcons.shareOutline,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  MdiIcons.bookmarkOutline,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              (progress[index] == null ||
                                                      progress[index] == 0)
                                                  ? IconButton(
                                                      tooltip:
                                                          "Tap to Download",
                                                      onPressed: () {
                                                        downloadNotes(
                                                            data[index]['link'],
                                                            data[index]['id'],
                                                            index);
                                                      },
                                                      icon: Icon(
                                                        MdiIcons.download,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  : (progress[index] == 1)
                                                      ? IconButton(
                                                          tooltip:
                                                              "Tap to Delete",
                                                          onPressed: () {
                                                            showDeleteDialog(
                                                                context, index);
                                                            //deleteDownloaded(index);
                                                          },
                                                          icon: Icon(MdiIcons
                                                              .checkboxMarkedCircle),
                                                          color: Colors.green,
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 18),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                              height: 15,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth:
                                                                    1.5,
                                                                valueColor:
                                                                    AlwaysStoppedAnimation(
                                                                        Colors
                                                                            .blue),
                                                                value: (progress[
                                                                            index] ==
                                                                        null)
                                                                    ? 0
                                                                    : progress[
                                                                        index],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          15),
                                                            ),
                                                          ],
                                                        ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // LinearProgressIndicator(
                                    //     value: (progress[index] == null)
                                    //         ? 0
                                    //         : progress[index]),
                                    //Divider(height: 10.0,),
                                  ],
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
