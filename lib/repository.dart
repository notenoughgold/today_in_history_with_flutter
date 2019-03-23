import 'dart:convert';

import 'package:today_in_history/today.dart';
import 'package:http/http.dart' as http;

class Repository {
  Repository();

  final baseUrl = "https://history.muffinlabs.com/date/";

  Future<Today> fetchTodayInHistory(month, day) async {
    var fetchUrl = baseUrl + month + "/" + day;
    var response = await http.get(fetchUrl);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var todayObj = Today.fromJson(json.decode(response.body));
      return todayObj;
    } else {
      // If that response was not OK, throw an error.
      print("loading failed");
      throw Exception('Failed to load');
    }
  }
}
