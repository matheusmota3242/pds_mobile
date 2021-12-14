import 'package:flutter/material.dart';
import 'package:pds_mobile/models/parametro_ativo.dart';
import 'package:pds_mobile/services/api_service.dart';

import 'home_view.dart';
import 'widgets/menu_drawer.dart';

class ParametroAtivoListView extends StatefulWidget {
  const ParametroAtivoListView({Key? key}) : super(key: key);

  @override
  _ParametroAtivoListViewState createState() => _ParametroAtivoListViewState();
}

class _ParametroAtivoListViewState extends State<ParametroAtivoListView> {
  final ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parâmetros'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeView())),
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const MenuDrawer(),
      body: FutureBuilder(
          future: _apiService.receberTodos(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            var data = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('waiting...');
                break;
              case ConnectionState.active:
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const Text('ok');
                    });
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        ParametroAtivo parametroAtivo =
                            ParametroAtivo.fromJson(data[index]);
                        return Text(parametroAtivo.simbolo);
                      });
                }
                return Text('Vazio');

                break;
              default:
                return Text('default');
            }
          }),
    );
  }
}
