import 'package:autos/pages/acerca_de.dart'; // Importa la nueva página
import 'package:autos/pages/tab_autos.dart';
import 'package:autos/pages/tab_marcas.dart';
import 'package:flutter/material.dart';

// Es mejor convertirlo a StatefulWidget para manejar el TabController si es necesario
class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API autos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Marcas'),
            Tab(text: 'Autos'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Certamen 2",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              accountEmail: Text(
                "Desarrollo Móvil",
                style: TextStyle(color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.webp'),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Autos USM'),
              onTap: () {
                _tabController.animateTo(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcercaDePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [TabMarcas(), TabAutos()],
      ),
    );
  }
}
