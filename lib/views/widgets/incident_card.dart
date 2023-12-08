import 'package:flutter/material.dart';
import 'package:zabbix_mobile/models/teste.dart';
import 'package:zabbix_mobile/views/sources/constants.dart';

class IncidentCard extends StatelessWidget {
  const IncidentCard({
    super.key,
    required this.backgroundColor,
    required this.actualHost,
  });

  final Color backgroundColor;
  final HostEvent actualHost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: defaultpd * 2, horizontal: defaultpd),
        width: double.infinity,
        height: defaultpd * 13,
        margin: const EdgeInsets.symmetric(vertical: defaultpd),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(defaultpd),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              actualHost.hostname,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: defaultpd * 2),
            ),
            Text(actualHost.eventName),
            const Spacer(),
            Text(
              actualHost.clock,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
