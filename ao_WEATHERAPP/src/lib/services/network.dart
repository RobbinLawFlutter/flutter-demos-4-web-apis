import 'package:http/http.dart' as http;
//dart:convert allows us to use jsonDecode
import 'dart:convert';

class NetworkService {
  NetworkService(this.url);
  final Uri url;

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('response status code: ${response.statusCode}');
    }
  }
}
