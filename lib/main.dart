import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabbix_mobile/views/pages/home_dashboard.dart';
import 'package:zabbix_mobile/views/pages/login_page.dart';

void main() {
  runApp(GetMaterialApp(initialRoute: '/login', getPages: [
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/home_dashboard', page: () => const HomeDashboard()),
  ]));
}
