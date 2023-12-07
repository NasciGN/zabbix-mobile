import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UserAPI extends GetxController {
  RxString apicode = ''.obs;
  RxString url = ''.obs;

  Future<void> login(String user, String pass, String urlSite) async {
    String urlAPI = 'http://$urlSite/api_jsonrpc.php';
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "user.login",
      "params": {"username": user, "password": pass},
      "id": 1
    };
    String result = await jsonStringRequest(requestBody, urlAPI);
    apicode.value = result;
    url.value = urlAPI;
    print(apicode.value);
    update();
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
