import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabbix_mobile/controllers/api_user.dart';
import 'package:zabbix_mobile/views/pages/home_dashboard.dart';
import 'package:zabbix_mobile/views/pages/host_search.dart';
import 'package:zabbix_mobile/views/pages/login_page.dart';

void main() {
  Get.put(UserAPI());
  runApp(GetMaterialApp(
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => const LoginPage()),
      GetPage(name: '/home_dashboard', page: () => const HomeDashboard()),
      GetPage(name: '/host_search', page: () => const HostSearhPage())
    ],
    theme: ThemeData(
      fontFamily: 'Roboto',
      useMaterial3: false,
    ),
  ));
}
