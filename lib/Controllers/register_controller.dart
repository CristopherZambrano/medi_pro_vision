import 'dart:convert';

import 'package:medi_pro_vision/Global/api_interceptors.dart';
import 'package:medi_pro_vision/Models/user.dart';

final ApiInterceptor api = ApiInterceptor();

Future<HttpBaseResponse> registerPatient(
  String name,
  String lastName,
  String email,
  String password,
  String birthday,
  String phone,
  String gender,
  String idNumber,
  String address,
) async {
  try {
    final response = await api.post('/registerPatient', {
      'name': name,
      'lastName': lastName,
      'birthday': birthday,
      'gender': gender,
      'cellPhone': phone,
      'email': email,
      'password': password,
      'address': address,
      'idNumber': idNumber,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return HttpBaseResponse.fromJson(decodedData as Map<String, dynamic>);
    } else {
      return HttpBaseResponse(
          code: 500, message: "Error de conexión", data: null);
    }
  } on Exception {
    return HttpBaseResponse(
        code: 400, message: "Ocurrio un error interno", data: null);
  }
}

Future<HttpBaseResponse> registerDoctor(
  String name,
  String lastName,
  String email,
  String password,
  String birthday,
  String phone,
  String gender,
  String idNumber,
  String address,
  String speciality,
  String description,
) async {
  try {
    final response = await api.post('/registerDoctor', {
      'name': name,
      'lastName': lastName,
      'birthday': birthday,
      'gender': gender,
      'cellPhone': phone,
      'email': email,
      'password': password,
      'address': address,
      'idNumber': idNumber,
      'speciality': speciality,
      'description': description,
    });
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return HttpBaseResponse.fromJson(decodedData as Map<String, dynamic>);
    } else {
      return HttpBaseResponse(
          code: 500, message: "Error de conexión", data: null);
    }
  } on Exception {
    return HttpBaseResponse(
        code: 400, message: "Error de conexión", data: null);
  }
}
