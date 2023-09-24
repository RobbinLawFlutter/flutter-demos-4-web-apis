// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const apiToken = 'QTVXCOASBD3ZIC1J';

class StockService {
  Future getCompanyInfo(String symbol) async {
    var url = Uri.parse(
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$symbol&apikey=$apiToken');

    http.Response response = await http.get(url);
    print('jsonDecode of response.body is ${jsonDecode(response.body)}');
    if (response.statusCode != 200) {
      print('Response Status for getCompanyInfo is ${response.statusCode}');
    } else if (response.statusCode != 200) {
    } else if (response.statusCode != 200) {
      return jsonDecode(response.body);
    }
  }

  Future getQuote(String symbol) async {
    var url = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiToken');

    http.Response response = await http.get(url);
    print(jsonDecode(response.body)['Global Quote']);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['Global Quote'];
    } else {
      print('Response Status for getQuote is ${response.statusCode}');
    }
  }
}
