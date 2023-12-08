import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zabbix_mobile/controllers/api_host.dart';
import 'package:zabbix_mobile/controllers/api_incident.dart';
import 'package:zabbix_mobile/models/Problem.dart';
import 'package:zabbix_mobile/models/teste.dart';
import 'package:zabbix_mobile/views/sources/constants.dart';
import 'package:zabbix_mobile/views/widgets/incident_card.dart';

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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIncidents();
  }

  int count = 0;
  Future<void> fetchIncidents() async {
    count = 0;
    setState(() {
      isLoading = true;
    });

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
        severity: problem['severity'],
      );

      hostsList.add(host);
    }

    setState(() {
      isLoading = false;
    });
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
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.offNamed('/host_search');
                    },
                    icon: const FaIcon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _handleRefresh(),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: hostsList.length,
                        itemBuilder: (context, index) {
                          HostEvent actualHost = hostsList[index];
                          Color backgroundColor =
                              mapSeverityToColor(actualHost.severity);
                          return IncidentCard(
                            backgroundColor: backgroundColor,
                            actualHost: actualHost,
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
