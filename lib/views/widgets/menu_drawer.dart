import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Parâmetros'),
          ),
        ],
      ),
    );
  }
}
