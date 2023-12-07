import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UserAPI extends GetxController {
  RxString apicode = ''.obs;

  Future<void> login(String user, String pass, String url) async {
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "user.login",
      "params": {"user": user, "password": pass},
      "id": 1
    };

    String result = await jsonStringRequest(requestBody, url);
    apicode.value = result;
  }

  Future<String> jsonStringRequest(jsonBody, String url) async {
    String requestBodyJson = jsonEncode(jsonBody);

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["result"].toString();
    } else {
      return '';
    }
  }
}
