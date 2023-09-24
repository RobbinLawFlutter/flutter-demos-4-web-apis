import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const apiToken = 'Tpk_27e2aa9354b742e4aac4092f8d2b7f59';
//const apiToken = 'pk_27889a5039724b219fae2d4218132354';

class StockService {
  Future getQuote(String symbol) async {
    var url =
        Uri.parse('https://sandbox.iexapis.com/stable/stock/$symbol/quote?token=$apiToken');
    http.Response response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Response Status is ${response.statusCode}');
    }
  }
}
