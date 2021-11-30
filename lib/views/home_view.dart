import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pds_mobile/models/parametro_acao.dart';
import 'package:pds_mobile/services/api_service.dart';
import 'package:pds_mobile/services/firebase_notificacao_service.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ApiService _apiService = ApiService();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final ParametroAcao _parametroAcao = ParametroAcao();
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
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: 'Tíquete',
                onChanged: (value) => _parametroAcao.tiquete = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: '0.00',
                onChanged: (value) {
                  _parametroAcao.valor = double.parse(value);
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  splashColor: Colors.black,
                  color: Colors.black,
                  onPressed: () {
                    _apiService.salvarParametroAcao(_parametroAcao);
                  },
                  icon: const Icon(Icons.send),
                ))
          ]),
        ),
      ),
    );
  }
}
