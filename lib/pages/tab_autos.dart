import 'package:autos/pages/autos_agregar.dart';
import 'package:autos/pages/auto_detalle.dart'; // Importa la nueva página
import 'package:flutter/material.dart';
import 'package:autos/provider/autos_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class TabAutos extends StatefulWidget {
  const TabAutos({super.key});

  @override
  State<TabAutos> createState() => _TabAutosState();
}

class _TabAutosState extends State<TabAutos> {
  final AutosProvider provider = AutosProvider();
  //Esto sirve para formatear el precio a la moneda actual uwu
  final fPrecio = NumberFormat.currency(
    locale: 'es-CL',
    decimalDigits: 0,
    symbol: '\$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ENCABEZADO DE LA TABLA
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    'Detalle',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Auto',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Precio',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1),
          // De aqui para abajo corresponde a la lista de autos
          Expanded(
            child: FutureBuilder(
              future: provider.getAutos(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var auto = snapshot.data[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          // Columna 1 Botón de Detalle
                          SizedBox(
                            width: 70,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.all(8),
                              ),
                              child: Icon(
                                MdiIcons.carInfo,
                                color: Colors.purple,
                              ),
                              onPressed: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) =>
                                      AutosDetalle(auto: auto),
                                );
                                // Navega y espera un resultado (si se borró el auto)
                                Navigator.push(context, route).then((
                                  seBorroAlgo,
                                ) {
                                  if (seBorroAlgo == true) {
                                    setState(() {}); // Refresca la lista
                                  }
                                });
                              },
                            ),
                          ),
                          // Columna 2 Info del Auto
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(auto['patentes']),
                                  Text(auto['modelo']),
                                ],
                              ),
                            ),
                          ),
                          // Columna 3 Precio
                          SizedBox(
                            width: 100,
                            child: Text(
                              '${auto['precio']}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => AutosAgregar(),
          );
          Navigator.push(context, route).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green,
        shape: CircleBorder(),
      ),
    );
  }
}
