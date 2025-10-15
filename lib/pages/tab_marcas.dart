import 'package:autos/pages/marcas_agregar.dart';
import 'package:autos/provider/autos_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabMarcas extends StatefulWidget {
  const TabMarcas({super.key});

  @override
  State<TabMarcas> createState() => _TabMarcasState();
}

class _TabMarcasState extends State<TabMarcas> {
  AutosProvider provider = AutosProvider();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: provider.getMarcas(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ObjectKey(snapshot.data[index]),
                    background: Container(color: Colors.purple),
                    secondaryBackground: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Borrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(MdiIcons.trashCan, color: Colors.white),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      var nombre = snapshot.data[index]['nombre'];
                      setState(() {
                        provider.marcasBorrar(snapshot.data[index]['id']).then((
                          borradoExitoso,
                        ) {
                          if (!borradoExitoso) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('Ocurrió un problema'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('Marca $nombre borrada'),
                              ),
                            );
                          }
                        });
                        snapshot.data.removeAt(index);
                      });
                    },
                    child: ListTile(
                      leading: Icon(MdiIcons.car),
                      title: Text(snapshot.data[index]['nombre']),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => MarcasAgregar(),
              );
              Navigator.push(context, route).then((value) {
                setState(() {});
              });
            },
            child: Text('Agregar Marca'),
          ),
        ),
      ],
    );
  }
}
