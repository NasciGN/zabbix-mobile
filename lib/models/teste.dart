class HostEvent {
  String hostID, hostname, eventName, clock, severity;

  HostEvent({
    required this.hostID,
    required this.hostname,
    required this.eventName,
    required this.clock,
    required this.severity,
  });
}
