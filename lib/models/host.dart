class Host {
  String id, host, name, status, inventoryMode, activeAvailable;

  Host({
    required this.id,
    required this.host,
    this.name = '',
    required this.status,
    required this.inventoryMode,
    required this.activeAvailable,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'host': host,
      'name': name,
      'status': status,
      'inventory_mode': inventoryMode,
      'active_available': activeAvailable,
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
        activeAvailable: json['active_available'],
      );
    } else {
      return Host(
          id: '', host: '', status: '', inventoryMode: '', activeAvailable: '');
    }
  }
}
