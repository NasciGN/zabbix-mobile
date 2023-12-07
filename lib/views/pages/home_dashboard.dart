import 'package:flutter/material.dart';
import 'package:zabbix_mobile/sources/constants.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(defaultpd * 2),
        child: Text(
          'Hosts',
          style:
              TextStyle(fontSize: defaultpd * 4.5, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
