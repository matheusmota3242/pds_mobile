import 'dart:convert';

import 'package:pds_mobile/models/parametro_acao.dart';
import 'package:http/http.dart' as http;
import 'package:pds_mobile/services/firebase_notificacao_service.dart';

class ApiService {
  static const apiUrl = "192.168.15.188:8080";

  final int _httpStatusOK = 200;

  void salvarParametroAcao(ParametroAcao parametroAcao) async {
    String path = "/parametro-acao/salvar";
    parametroAcao.token = await FirebaseNotificacaoService().getToken();
    http.Response response = await http.post(Uri.http(apiUrl, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parametroAcao));

    if (response.statusCode == _httpStatusOK) {
      print('OK');
    } else {
      print(response.body.toString());
    }
  }
}
