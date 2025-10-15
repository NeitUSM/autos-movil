import 'package:flutter/material.dart';
import 'package:autos/provider/autos_provider.dart';
import 'package:intl/intl.dart';

class AutosDetalle extends StatelessWidget {
  final Map<String, dynamic> auto;

  AutosDetalle({required this.auto});

  final fPrecio = NumberFormat.currency(
    locale: 'es-CL',
    decimalDigits: 0,
    symbol: '\$',
  );
  final provider = AutosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Auto'),
        backgroundColor: Colors.purple, // Color como en la imagen de referencia
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 20, color: Colors.black),
                children: [
                  TextSpan(text: 'Detalle del auto patente '),
                  TextSpan(
                    text: '${auto['patentes']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(height: 20, color: Colors.grey.shade200),
            Text(
              'Patente: ${auto['patentes']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Marca: ${auto['marca']['nombre']}',
              style: TextStyle(fontSize: 16),
            ),
            Text('Modelo: ${auto['modelo']}', style: TextStyle(fontSize: 16)),
            Spacer(), // Empuja el contenido siguiente al final
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        TextSpan(text: 'Precio: '),
                        TextSpan(
                          text: '${fPrecio.format(auto['precio'])}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.delete, color: Colors.white),
                label: Text('Borrar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                onPressed: () {
                  provider.autosBorrar(auto['patentes']).then((borrado) {
                    if (borrado) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Auto ${auto['modelo']} eliminado con éxito',
                          ),
                        ),
                      );
                      // Regresa a la vista anterior, pasando 'true' para indicar que se borró algo
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No se pudo eliminar el auto')),
                      );
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
