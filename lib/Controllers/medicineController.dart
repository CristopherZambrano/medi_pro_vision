import 'dart:convert';

import 'package:medi_pro_vision/Global/api_interceptors.dart';
import 'package:medi_pro_vision/Models/Medicamentos.dart';
import 'package:medi_pro_vision/Models/user.dart';

final ApiInterceptor api = ApiInterceptor();

Future<List<Medicine>> listMedicine() async {
  try {
    final response = await api.get('/listMedicine');
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Medicine.fromJson(item)).toList();
    }else{
      throw Exception('Error al obtener los datos');
    }
  } on Exception {
    throw Exception('Error al obtener los datos');
  }
}
