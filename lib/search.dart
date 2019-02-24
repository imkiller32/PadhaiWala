import 'package:flutter/material.dart';
import 'module.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'utils.dart';

class DataSearch extends SearchDelegate<String> {
  Module module = Module();
  List data;
  List names = [];
  List recentNames = [];
  final String url = "http://liveism.xyz/fetch.php";
  DataSearch(this.data) {
    int len = data.length;
    // for (int i = 0; i < len; i++) names.add((data[i]['name']).toString().toUpperCase());
    // for (int i = 0; i < len / 5; i++) recentNames.add((data[i]['name']).toString().toUpperCase());
    print(names);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Colors.blue,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      color: Colors.red,
      shape: StadiumBorder(),
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : data.where((p) => p['name'].startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            onTap: () {
              openUrl(data[index]['link'], data[index]['name']);
              // showResults(context);
            },
            leading: CachedNetworkImage(
              imageUrl: data[index]['image'],
              width: 40.0,
              height: 40.0,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: RichText(
                text: TextSpan(
                    text: suggestionList[index]['name']
                        .substring(0, query.length)
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: suggestionList[index]['name']
                          .substring(query.length)
                          .toString()
                          .toUpperCase(),
                      style: TextStyle(color: Colors.grey))
                ])),
          ),
      itemCount: suggestionList.length,
    );
  }
}
