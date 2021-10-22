import "dart:async";
import "dart:convert";
import "dart:io";

import 'package:financial_app/models/user.dart';
import 'package:financial_app/utils/network_manager.dart';


class API {
  NetworkManager _networkManager = new NetworkManager();

  static final String apiUrl = "https://jsonplaceholder.typicode.com/users";

  Future<UserList?> getListFromServer() async {
    try {
      var headers = Map<String, String>();
      headers["Content-Type"] = "application/json";

      ParsedResponse result = await _networkManager.get(apiUrl, headers: headers);
      print(result.response ?? "NULL RESPONSE");
      if (result.isOk()) {
        final modelClassResponse = UserList.fromJsonMap(json.decode(result.response??""));
        return modelClassResponse;
      } else if (result.response?.isNotEmpty ?? false) {
        final errorApiResponse = ErrorApiResponse.fromJson(json.decode(result.response??""));
        if (errorApiResponse.error?.message?.isNotEmpty ?? false) {
          throw Exception(errorApiResponse.error?.message);
        } else {
          throw Exception();
        }
      } else {
        throw Exception("Unexpected error in Report API [${result.code ?? "null"}]");
      }
    } catch (e) {
      throwProperException(e);
    }
  }


}


void throwProperException(e) {
  if (e is SocketException) {
    throw Exception("Unable to communicate with server at the moment");
  } else if (e is TimeoutException) {
    throw Exception(("Unable to communicate with server at the moment"));
  } else if (e is FormatException) {
    throw Exception(("Invalid File Format"));
  } else {
    throw e;
  }
}

class ParsedResponse {
  int? code;
  String? response;

  ParsedResponse(this.code, this.response);

  bool isOk() {
    return code == 200;
  }
}

class ParsedStringResponse {
  String code;
  String response;

  ParsedStringResponse(this.code, this.response);

  bool isOk() {
    return code == "Success";
  }
}

class ErrorApiResponse {
  Error? error;

  ErrorApiResponse({this.error});

  factory ErrorApiResponse.fromJson(Map<String, dynamic> json) {
    return ErrorApiResponse(
      error: json["error"] != null ? Error.fromJson(json["error"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data["error"] = this.error!.toJson();
    }
    return data;
  }
}

class Error {
  int? code;
  String? key;
  String? message;

  Error({this.code, this.key, this.message});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json["code"],
      key: json["key"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["code"] = this.code;
    data["key"] = this.key;
    data["message"] = this.message;
    return data;
  }
}

errorMessage(String message) {
  if (message.isEmpty) {
    message = "Something went wrong";
  } else if (message.contains("Exception:")) {
    message = message.replaceFirst("Exception:", "");
  }
  return message;
}