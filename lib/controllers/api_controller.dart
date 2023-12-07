import 'dart:convert';
import 'package:http/http.dart' as http;

class ControllerAPI {
  String url = 'https://zabbix.bulletinet.com.br/api_jsonrpc.php';

  Future<List<dynamic>> jsonMapRequest(jsonBody) async {
    String requestBodyJson = jsonEncode(jsonBody);

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: requestBodyJson,
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['result'] != null) {
        return responseData['result'];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<String> jsonStringRequest(jsonBody) async {
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

  bool isValidRequest(request) {
    if (request.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
