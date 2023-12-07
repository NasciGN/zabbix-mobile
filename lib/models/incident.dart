class Host {
  int eventId;
  String name;
  int clock;

  Host({
    required this.eventId,
    required this.name,
    required this.clock,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'name': name,
      'clock': clock,
    };
  }

  factory Host.fromJson(Map<String, dynamic>? json) {
    if (json != null && json.isNotEmpty) {
      return Host(
        eventId: json['eventid'] ?? 0,
        name: json['name'] ?? '',
        clock: json['clock'] ?? 0,
      );
    } else {
      return Host(eventId: 0, name: '', clock: 0);
    }
  }

  DateTime getDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(clock * 1000);
  }
}
