import 'dart:async';

import 'package:financial_app/helpers/api_helper.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  static NetworkManager _instance = new NetworkManager.internal();

  NetworkManager.internal();

  factory NetworkManager() => _instance;

  Future<ParsedResponse> get(String url, {Map<String,String>? headers}) {

    print("URL : $url Headers $headers");

    return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code for " + url + "::: " + statusCode.toString());
      print("Response ::: " + res);

      if (res == null || res.isEmpty) {

        throw Exception("Empty response");

      } else {
        return new ParsedResponse(statusCode, res);
      }
    }).catchError((Object e) {
      //TODO : Confirm network status
      throw Exception("Empty response");
    });
  }


  Future<ParsedResponse> post(String url,{required Map<String,String> headers, body, encoding, required Map<String,dynamic> params}) {

    var tempUrl = Uri.parse(url);

    print("URL : $url \nHeaders $headers\nBody $body\nEnconding $encoding");

    return http.post(tempUrl, body: body, headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print("Status code for " + url + "::: " + statusCode.toString());
      print("Response ::: " + res);

      if (res == null || res.isEmpty) {
        throw Exception("Empty response");
      } else {
        return new ParsedResponse(statusCode, res);
      }
    }).catchError((Object e) {
      throw e;
    }).timeout(Duration(seconds: 5), onTimeout: () {
      throw TimeoutException("Timeout");
    });
  }
}
