import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pds_mobile/models/parametro_ativo.dart';

import 'package:http/http.dart' as http;
import 'package:pds_mobile/services/firebase_notificacao_service.dart';

class ApiService {
  static const apiUrl = "10.0.2.2:8080";
  //static const apiUrl = "192.168.15.188:8080";

  Future salvarParametroAcao(ParametroAtivo parametroAtivo) async {
    String path = "/parametro-ativo/salvar";
    parametroAtivo.token = await FirebaseNotificacaoService().getToken();
    http.Response response = await http.post(Uri.http(apiUrl, path),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(parametroAtivo));
    if (response.statusCode == HttpStatus.ok) {
      return Fluttertoast.showToast(
          msg: "Enviado com sucesso", gravity: ToastGravity.CENTER);
    } else {
      return Fluttertoast.showToast(
          msg: "Ocorreu um erro", gravity: ToastGravity.CENTER);
    }
  }

  Future receberTodos() async {
    String path = "/parametro-ativo/recuperar";
    http.Response response = await http.get(Uri.http(apiUrl, path));
    var body = json.decode(response.body);

    return body;
  }

  Future remover(int id) async {
    String path = "/parametro-ativo/${id.toString()}/remover";
    bool result = false;
    http.Response response = await http.delete(Uri.http(apiUrl, path));
    if (response.statusCode == HttpStatus.ok) {
      return Fluttertoast.showToast(
          msg: 'Parâmetro removido com sucesso', gravity: ToastGravity.CENTER);
    } else if (response.statusCode == HttpStatus.notFound) {
      return Fluttertoast.showToast(
          msg: 'Parâmetro não existe mais', gravity: ToastGravity.CENTER);
    }
    return Fluttertoast.showToast(
        msg: 'Ocorreu um erro', gravity: ToastGravity.CENTER);
  }
}
