import 'dart:collection';
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class AutosProvider {
  final String apiUrl = 'http://10.0.2.2:80/api';

  Future<List<dynamic>> getMarcas() async {
    var uri = Uri.parse('$apiUrl/marcas');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> marcasAgregar(
    String nombreMarca,
  ) async {
    var uri = Uri.parse('$apiUrl/marcas');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{'nombre': nombreMarca}),
    );
    return json.decode(respuesta.body);
  }

  Future<bool> marcasBorrar(int id) async {
    var uri = Uri.parse('$apiUrl/marcas/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<List<dynamic>> getAutos() async {
    var uri = Uri.parse('$apiUrl/autos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<bool> autosBorrar(String patente) async {
    var uri = Uri.parse('$apiUrl/autos/$patente');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> autosAgregar(
    String patente,
    String modelo,
    int precio,
    int marcaId,
  ) async {
    var uri = Uri.parse('$apiUrl/autos');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'patente': patente,
        'modelo': modelo,
        'precio': precio,
        'marca': marcaId,
      }),
    );
    debugPrint('Respuesta autosAgregar: ${respuesta.body}');
    return json.decode(respuesta.body);
  }
}
