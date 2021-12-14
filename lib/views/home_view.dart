import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pds_mobile/models/parametro_ativo.dart';
import 'package:pds_mobile/services/api_service.dart';
import 'package:pds_mobile/services/firebase_notificacao_service.dart';

import 'parametro_ativo_list_view.dart';
import 'widgets/menu_drawer.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ApiService _apiService = ApiService();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final ParametroAtivo _parametroAtivo = ParametroAtivo();
  static const String _tipoAtivoAcao = "ACAO";
  Random random = Random();
  @override
  void initState() {
    super.initState();
    FirebaseNotificacaoService.init();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        FirebaseNotificacaoService.showNotification(
            title: notification.title, body: notification.body, payload: "");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo parâmetro ação'),
      ),
      drawer: const MenuDrawer(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: 'Tíquete',
                onChanged: (value) => _parametroAtivo.simbolo = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: '0.00',
                onChanged: (value) {
                  _parametroAtivo.valor = double.parse(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                splashColor: Colors.black,
                color: Colors.black,
                onPressed: () async {
                  _parametroAtivo.tipoAtivo = _tipoAtivoAcao;
                  await _apiService.salvarParametroAcao(_parametroAtivo);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ParametroAtivoListView()));
                },
                icon: const Icon(Icons.send),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
