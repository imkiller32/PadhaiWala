import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Module {
  List data;
  Future<List> getJsonData(String url) async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print('hell' + response.toString());
    // if (response != 200) {
    //   showDes('Can' + 't Connect to network');
    //   return data;
    // }
    var convertDataToJson = json.decode(response.body);
    data = convertDataToJson;
    return data;
  }
}

class AdditionalSettings {
  bool darkTheme;
  bool pdfDarkTheme;

  AdditionalSettings(this.darkTheme, this.pdfDarkTheme);

  void setTheme(darkTheme) {
    this.darkTheme = darkTheme;
  }

  void setPdf(pdfDarkTheme) {
    this.pdfDarkTheme = pdfDarkTheme;
  }

  bool getTheme() {
    return this.darkTheme;
  }

  bool getPdfTheme() {
    return this.pdfDarkTheme;
  }
}

AdditionalSettings additionalSettings = AdditionalSettings(false, true);
