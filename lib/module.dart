import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Module {
  List data;
  Future<List> getJsonData(String url) async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var convertDataToJson = json.decode(response.body);
    data = convertDataToJson;

    return data;
  }
}
