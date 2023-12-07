import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zabbix_mobile/controllers/api_user.dart';

class HostAPI {
  UserAPI userAPI = Get.find<UserAPI>();

  Future<dynamic> getProblems() async {
    String token = userAPI.apicode.value;
    String url = userAPI.url.value;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'jsonrpc': '2.0',
        'method': 'problem.get',
        'params': {
          'output': [
            'eventid',
            'objectid',
            'object',
            'clock',
            'acknowledged',
            'value',
            'severity',
          ],
          'sortfield': ['eventid'],
          'limit': 20,
          'sortorder': 'DESC'
        },
        'auth': token,
        'id': 1,
      }),
    );

    final responseBody = jsonDecode(response.body);

    final problems = responseBody['result'];
    return problems;
  }

  Future<Map<String, dynamic>> getTrigger(String triggerId) async {
    String token = userAPI.apicode.value;
    String url = userAPI.url.value;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'jsonrpc': '2.0',
        'method': 'trigger.get',
        'params': {
          'triggerids': triggerId,
          'selectHosts': 'extend',
        },
        'auth': token,
        'id': 1,
      }),
    );

    final responseBody = jsonDecode(response.body);
    final trigger = responseBody['result'][0];

    return trigger;
  }
}
