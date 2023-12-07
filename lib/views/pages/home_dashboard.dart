import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zabbix_mobile/controllers/api_host.dart';
import 'package:zabbix_mobile/controllers/api_incident.dart';
import 'package:zabbix_mobile/models/Problem.dart';
import 'package:zabbix_mobile/models/teste.dart';
import 'package:zabbix_mobile/sources/constants.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  HostAPI apiHost = HostAPI();
  IncidentAPI apiIncident = IncidentAPI();

  List<HostEvent> hostsList = [];
  List<Problem> allIncidents = [];

  @override
  void initState() {
    super.initState();
    fetchIncidents();
  }

  int count = 0;
  Future<void> fetchIncidents() async {
    count = 0;
    List<dynamic> problems = await apiIncident.getProblems();
    allIncidents.clear();
    hostsList.clear();

    for (var problem in problems) {
      count++;
      String formatDurantion = formatDuration(problem['clock']);
      final trigger = await apiIncident.getTrigger(problem['objectid']);
      HostEvent host = HostEvent(
          hostID: trigger['hosts'][0]["hostid"],
          hostname: trigger['hosts'][0]["host"],
          eventName: trigger['description'],
          clock: formatDurantion,
          severity: problem['severity']);

      hostsList.add(host);
    }
    setState(() {});
  }

  Future<void> _handleRefresh() async {
    await fetchIncidents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0E1012),
      body: Padding(
        padding: const EdgeInsets.all(defaultpd * 2),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Text(
                      'Incidentes',
                      style: TextStyle(
                          fontSize: defaultpd * 4.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Get.offNamed('/host_search');
                        },
                        icon: const FaIcon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ],
                )),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _handleRefresh(),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: hostsList.length,
                  itemBuilder: (context, index) {
                    HostEvent actualHost = hostsList[index];
                    Color backgroundColor =
                        mapSeverityToColor(actualHost.severity);
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: defaultpd * 2),
                            ),
                            Text(actualHost.eventName),
                            const Spacer(),
                            Text(
                              actualHost.clock,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
