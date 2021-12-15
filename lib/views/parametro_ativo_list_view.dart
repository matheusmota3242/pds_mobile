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
                return const Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const Text('ok');
                    });
                break;
              case ConnectionState.none:
                return const Center(
                  child: Text('Não há conexão.'),
                );
              case ConnectionState.done:
                Widget body = Container();
                if (snapshot.hasData && data.length > 0) {
                  body = ListView.separated(
                      separatorBuilder: (context, index) => Container(
                            height: 1,
                            width: double.maxFinite,
                            color: Colors.black,
                          ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        ParametroAtivo parametroAtivo =
                            ParametroAtivo.fromJson(data[index]);
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(parametroAtivo.simbolo),
                                  Text('Parâmetro: ' +
                                      parametroAtivo.valor.toString()),
                                ],
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await _apiService
                                        .remover(parametroAtivo.id);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        );
                      });
                } else if (!snapshot.hasData) {
                  body = const Center(
                    child: Text('Não há conexão'),
                  );
                } else if (data.length == 0) {
                  body = const Center(
                      child: Text('Não há parâmetros cadastrados'));
                }
                return body;
                break;
              default:
                return Text('default');
            }
          }),
    );
  }
}
