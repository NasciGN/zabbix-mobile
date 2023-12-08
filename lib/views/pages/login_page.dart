import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabbix_mobile/controllers/api_user.dart';
import 'package:zabbix_mobile/views/sources/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUrl = TextEditingController();
  final _controllerUser = TextEditingController();
  final _controllerPass = TextEditingController();

  final UserAPI userapi = Get.find<UserAPI>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultpd * 2),
          child: Padding(
            padding: const EdgeInsets.only(
                left: defaultpd * 5,
                right: defaultpd * 5,
                top: defaultpd * 20,
                bottom: defaultpd * 40),
            child: Column(
              children: [
                const Text(
                  'Zabbix\nMobile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: defaultpd / 4),
                ),
                const SizedBox(height: defaultpd * 8),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerUser,
                          decoration:
                              const InputDecoration(label: Text('Usuário')),
                        ),
                        TextFormField(
                          controller: _controllerPass,
                          obscureText: true,
                          decoration:
                              const InputDecoration(label: Text('Senha')),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                _mostrarDialogoServidor();
                              },
                              child: const Text(
                                'Cadastrar Servidor',
                                style: TextStyle(),
                              ),
                            )),
                        const SizedBox(
                          height: defaultpd * 25,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {});
                              await userapi.login(_controllerUser.text,
                                  _controllerPass.text, _controllerUrl.text);

                              Get.offNamed("/home_dashboard");
                              setState(() {});
                            }
                          },
                          child: Container(
                            height: defaultpd * 5,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 111, 116, 111),
                                borderRadius:
                                    BorderRadius.circular(defaultpd * 2)),
                            child: const Center(
                                child: Text(
                              'Acessar',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoServidor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configurar Servidor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _controllerUrl,
                decoration: const InputDecoration(labelText: 'URL do Servidor'),
              ),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
