import 'package:flutter/material.dart';
import 'package:zabbix_mobile/controllers/api_controller.dart';
import 'package:zabbix_mobile/controllers/api_host.dart';
import 'package:zabbix_mobile/models/host.dart';
import 'package:zabbix_mobile/sources/constants.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  HostAPI apiHost = HostAPI();
  ControllerAPI apiController = ControllerAPI();

  // Lista para armazenar os objetos Host
  List<Host> hostsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(defaultpd * 2),
        child: Column(
          children: [
            const Text(
              'Hosts',
              style: TextStyle(
                fontSize: defaultpd * 4.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<dynamic> hosts = await apiHost.getHosts("CONTINENTAL");

                // Limpa a lista antes de adicionar os novos itens
                hostsList.clear();

                // Adiciona os objetos Host à lista
                for (var hostData in hosts) {
                  Host host = Host.fromJson(hostData);
                  hostsList.add(host);
                }

                // Atualiza a interface do usuário
                setState(() {});
              },
              child: Text('Teste para chamada da API'),
            ),
            // Exibe a lista de hosts usando um ListView
            Expanded(
              child: ListView.builder(
                itemCount: hostsList.length,
                itemBuilder: (context, index) {
                  Host host = hostsList[index];
                  return ListTile(
                    title: Text(host.name),
                    subtitle: Text('Available: ${host.activeAvailable}'),
                    // Adicione mais detalhes conforme necessário
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
