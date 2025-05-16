import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> cargarRazas() async {
  final String response = await rootBundle.loadString('assets/razas_perros.json');
  final List<dynamic> data = json.decode(response);
  return data.cast<Map<String, dynamic>>();
}
