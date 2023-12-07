class HostAPI {
  Map<String, dynamic> getHosts(String token, String arg) {
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "output": ["hostid", "host", "status", "name", "inventory_mode"],
        "filter": {"name": arg}
      },
      "id": 1,
      "auth": token
    };
    return requestBody;
  }

  Map<String, dynamic> getHostGroups(String token, String arg) {
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "output": ["hostid", "groups"],
        "selectGroups": ["groupid", "name", "flags", "uuid"],
        "filter": {"host": arg}
      },
      "id": 1,
      "auth": token
    };
    return requestBody;
  }

  Map<String, dynamic> getHostTemplates(String token, String arg) {
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "output": ["hostid"],
        "selectParentTemplates": ["templateid", "name"],
        "hostids": arg
      },
      "id": 1,
      "auth": token
    };
    return requestBody;
  }

  Map<String, dynamic> getHostInventory(String token, String arg) {
    Map<String, dynamic> requestBody = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "output": ["host"],
        "selectInventory": ["os", "type", "hardware"],
        "searchInventory": {"os": arg}
      },
      "id": 1,
      "auth": token
    };
    return requestBody;
  }

  Map<String, dynamic> getHostIncidents(String token, String arg) {
    Map<String, dynamic> requestBody = {
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
    };
    return requestBody;
  }
}
