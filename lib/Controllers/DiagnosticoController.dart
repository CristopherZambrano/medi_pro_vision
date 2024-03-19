import 'dart:convert';

import 'package:http/http.dart';
import 'package:medi_pro_vision/Global/api_interceptors.dart';
import 'package:medi_pro_vision/Models/user.dart';

final ApiInterceptor api = ApiInterceptor();

Future<HttpBaseResponse> buscarPaciente(String document) async {
  try {
    final Response = await api.post('/findUserDoc', {"Documento": document});
    if (Response.statusCode == 200) {
      final decodedData = jsonDecode(Response.body);
      return HttpBaseResponse.fromJson(decodedData as Map<String, dynamic>);
    } else {
      return HttpBaseResponse(
          code: 500, message: "Error de conexión", data: null);
    }
  } on Exception {
    return HttpBaseResponse(code: 1, message: "Error en la data", data: null);
  }
}