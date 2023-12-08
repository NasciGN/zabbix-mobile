import 'package:flutter/material.dart';
import 'package:zabbix_mobile/models/host.dart';
import 'package:zabbix_mobile/views/sources/constants.dart';

class HostCard extends StatelessWidget {
  const HostCard({
    super.key,
    required this.host,
  });

  final Host host;

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
          color: const Color.fromARGB(255, 85, 83, 83),
          borderRadius: BorderRadius.circular(defaultpd),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              host.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: defaultpd * 2,
                  color: Colors.white),
            ),
            const SizedBox(
              height: defaultpd,
            ),
            int.tryParse(host.activeAvailable) == 0
                ? Container(
                    width: defaultpd * 10,
                    height: defaultpd * 4,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(defaultpd * 2)),
                    child: const Center(
                        child: Text(
                      'SNMP',
                      style: TextStyle(color: Colors.white),
                    )),
                  )
                : Container(
                    width: defaultpd * 10,
                    height: defaultpd * 4,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(defaultpd * 2)),
                    child: const Center(
                        child: Text(
                      'SNMP',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
          ],
        ),
      ),
    );
  }
}
