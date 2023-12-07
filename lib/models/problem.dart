class Problem {
  String eventid, objectid, object, clock, acknowledged, value, severity;

  Problem({
    required this.eventid,
    required this.objectid,
    required this.object,
    required this.clock,
    required this.acknowledged,
    required this.value,
    required this.severity,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      eventid: json['eventid'] ?? '',
      objectid: json['objectid'] ?? '',
      object: json['object'] ?? '',
      clock: json['clock'] ?? '',
      acknowledged: json['acknowledged'] ?? '',
      value: json['value'] ?? '',
      severity: json['severity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventid': eventid,
      'objectid': objectid,
      'object': object,
      'clock': clock,
      'acknowledged': acknowledged,
      'value': value,
      'severity': severity,
    };
  }
}
