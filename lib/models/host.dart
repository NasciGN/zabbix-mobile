class Host {
  String id, host, name, status, inventoryMode;

  Host({
    required this.id,
    required this.host,
    this.name = '',
    required this.status,
    required this.inventoryMode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'host': host,
      'name': name,
      'status': status,
      'inventory_mode': inventoryMode,
    };
  }

  factory Host.fromJson(Map<String, dynamic>? json) {
    if (json!.isNotEmpty) {
      return Host(
        id: json['hostid'],
        host: json['host'],
        name: json['name'] ?? json['host'],
        status: json['status'],
        inventoryMode: json['inventory_mode'],
      );
    } else {
      return Host(id: '', host: '', status: '', inventoryMode: '');
    }
  }
}
