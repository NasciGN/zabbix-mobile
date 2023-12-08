import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zabbix_mobile/controllers/api_host.dart';
import 'package:zabbix_mobile/models/host.dart';
import 'package:zabbix_mobile/views/sources/constants.dart';
import 'package:zabbix_mobile/views/widgets/host_card.dart';

class HostSearhPage extends StatefulWidget {
  const HostSearhPage({super.key});

  @override
  State<HostSearhPage> createState() => _HostSearhPageState();
}

class _HostSearhPageState extends State<HostSearhPage> {
  final _controllerSearch = TextEditingController();

  HostAPI apiHost = HostAPI();
  List<Host> hostsList = [];

  Future<void> fetchHosts(String search) async {
    List<dynamic> hosts = await apiHost.getHosts(search);
    hostsList.clear();

    for (var host in hosts) {
      Host newHost = Host.fromJson(host);
      hostsList.add(newHost);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0E1012),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultpd * 4, horizontal: defaultpd * 4),
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: defaultpd * 4,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Get.offNamed('/home_dashboard');
                },
                icon: const FaIcon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: defaultpd * 4,
            ),
            Column(children: [
              TextField(
                controller: _controllerSearch,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await fetchHosts(_controllerSearch.text);
                    },
                    icon: const FaIcon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            ]),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: hostsList.length,
                itemBuilder: (context, index) {
                  Host host = hostsList[index];
                  return HostCard(host: host);
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
