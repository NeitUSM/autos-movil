import 'package:flutter/material.dart';

class AcercaDePage extends StatelessWidget {
  const AcercaDePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Acerca de la Institución')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Logo de la USM
            Image.asset('assets/logo.webp', height: 150),
            SizedBox(height: 24),
            Text(
              'Universidad Técnica Federico Santa María',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Fundada el 20 de diciembre de 1931 por Federico Santa María Carrera, la UTFSM es una universidad chilena, privada y de vocación pública, perteneciente al Consejo de Rectores de las Universidades Chilenas. Su casa central se encuentra en Valparaíso y es reconocida por su liderazgo en ingeniería, ciencia y tecnología.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            Spacer(),
            Text(
              'Lema: "Ex Umbra in Solem" (De la sombra a la luz)',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
