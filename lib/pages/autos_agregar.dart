import 'package:flutter/material.dart';
import 'package:autos/provider/autos_provider.dart';

class AutosAgregar extends StatefulWidget {
  const AutosAgregar({super.key});

  @override
  State<AutosAgregar> createState() => _AutosAgregarState();
}

class _AutosAgregarState extends State<AutosAgregar> {
  final AutosProvider provider = AutosProvider();
  final TextEditingController patenteCtrl = TextEditingController();
  final TextEditingController modeloCtrl = TextEditingController();
  final TextEditingController precioCtrl = TextEditingController();

  List<dynamic> marcas = [];
  int? marcaSeleccionadaId;
  String error = '';

  @override
  void initState() {
    super.initState();
    provider.getMarcas().then((listaMarcas) {
      setState(() {
        marcas = listaMarcas;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Auto'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: patenteCtrl,
              decoration: InputDecoration(labelText: 'Patente'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: modeloCtrl,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: precioCtrl,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<int>(
              hint: Text('Seleccione una marca'),
              value: marcaSeleccionadaId,
              onChanged: (newValue) {
                setState(() {
                  marcaSeleccionadaId = newValue;
                });
              },
              items: marcas.map<DropdownMenuItem<int>>((marca) {
                return DropdownMenuItem<int>(
                  value: marca['id'],
                  child: Text(marca['nombre']),
                );
              }).toList(),
            ),
            Spacer(),
            Text(error, style: TextStyle(color: Colors.red)),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Agregar Auto'),
                onPressed: () async {
                  if (patenteCtrl.text.isEmpty ||
                      modeloCtrl.text.isEmpty ||
                      precioCtrl.text.isEmpty ||
                      marcaSeleccionadaId == null) {
                    setState(() {
                      error = 'Por favor, complete todos los campos';
                    });
                    return;
                  }

                  await provider.autosAgregar(
                    patenteCtrl.text.trim(),
                    modeloCtrl.text.trim(),
                    int.tryParse(precioCtrl.text) ?? 0,
                    marcaSeleccionadaId!,
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
