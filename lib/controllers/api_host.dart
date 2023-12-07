import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:zabbix_mobile/controllers/api_user.dart';

class HostAPI {
  UserAPI userAPI = Get.find<UserAPI>();

  Future<dynamic> getHosts(String arg) async {
    String token = userAPI.apicode.value;
    String url = '${userAPI.url.value}/api_jsonrpc.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
          "search": {"name": arg},
        },
        "id": 1,
        "auth": token
      }),
    );

    final responseBody = jsonDecode(response.body);
    final hosts = responseBody['result'];
    return hosts;
  }

  Future<dynamic> getHostGroups(String arg) async {
    String token = userAPI.apicode.value;
    String url = '${userAPI.url.value}/api_jsonrpc.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
          "output": ["hostid", "groups"],
          "selectGroups": ["groupid", "name", "flags", "uuid"],
          "filter": {"host": arg}
        },
        "id": 1,
        "auth": token
      }),
    );
    final responseBody = jsonDecode(response.body);

    final hostGroups = responseBody['result'];
    return hostGroups;
  }

  Future<dynamic> getHostTemplates(String arg) async {
    String token = userAPI.apicode.value;
    String url = '${userAPI.url.value}/api_jsonrpc.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
          "output": ["hostid"],
          "selectParentTemplates": ["templateid", "name"],
          "hostids": arg
        },
        "id": 1,
        "auth": token
      }),
    );
    final responseBody = jsonDecode(response.body);

    final hostTemplates = responseBody['result'];
    return hostTemplates;
  }

  Future<dynamic> getHostIncidents(String arg) async {
    String token = userAPI.apicode.value;
    String url = '${userAPI.url.value}/api_jsonrpc.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "problem.get",
        "params": {
          "output": ["eventid", "name", "clock"],
          "recent": "true",
          "hostids": arg,
          "limit": 10,
          "sortfield": ["eventid"],
          "sortorder": "DESC"
        },
        "id": 1,
        "auth": token
      }),
    );
    final responseBody = jsonDecode(response.body);

    final hostIncidents = responseBody['result'];
    return hostIncidents;
  }
}
