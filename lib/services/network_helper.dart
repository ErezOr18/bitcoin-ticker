import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper();

  Future<dynamic> getCoinData(final String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      dynamic coinData = jsonDecode(response.body);
      return coinData;
    } else {
      print(url);
      print(response.body);
      throw Exception('My Exception ${response.body}');
    }
  }
}
