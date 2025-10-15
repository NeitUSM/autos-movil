import 'package:autos/pages/tab_autos.dart';
import 'package:autos/pages/tab_marcas.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: Text('API autos'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Marcas',),
              Tab(text: 'Autos',),
            ]),
        ),
        body: TabBarView(children: [
          TabMarcas(),TabAutos()]),
      ));
  }
}