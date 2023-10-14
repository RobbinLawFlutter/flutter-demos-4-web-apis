// ignore_for_file: avoid_print

import 'dart:async';
import 'package:robbinlaw/services/network.dart';

const apiToken = 'QTVXCOASBD3ZIC1J';

class StockService {

  Future getCompanyInfo(String symbol) async {

    var urlUsingOneString = Uri.parse('https://www.alphavantage.co/query?function=OVERVIEW&symbol=$symbol&apikey=$apiToken');

    Uri url = Uri(
      scheme: 'https',
      host: 'www.alphavantage.co',
      path: '/query',
      query: 'function=OVERVIEW&symbol=$symbol&apikey=$apiToken'
    );
    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    return data;
  }

  Future getQuote(String symbol) async {

    var urlUsingOneString = Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiToken');

    Uri url = Uri(
      scheme: 'https',
      host: 'www.alphavantage.co',
      path: '/query',
      query: 'function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiToken'
    );
    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    return data;
  }
}
