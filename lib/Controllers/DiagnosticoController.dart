import 'dart:convert';
import 'package:medi_pro_vision/Global/api_interceptors.dart';
import 'package:medi_pro_vision/Models/user.dart';

final ApiInterceptor api = ApiInterceptor();

Future<HttpBaseResponse> buscarPaciente(String document) async {
  try {
    final response = await api.post('/findUserDoc', {"Documento": document});
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return HttpBaseResponse.fromJson(decodedData as Map<String, dynamic>);
    } else {
      return HttpBaseResponse(
          code: 500, message: "Error de conexión", data: null);
    }
  } on Exception {
    return HttpBaseResponse(code: 1, message: "Error en la data", data: null);
  }
}

Future<HttpBaseResponse> guardarDiagnostico(
    int idPatient, String diagnostico, String idUser) async {
  try {
    final response = await api.post('/registerDiagnosis', {
      "diagnostico": diagnostico,
      "idUser": idUser,
      "idPatient": idPatient.toString()
    });
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return HttpBaseResponse.fromJson(decodedData as Map<String, dynamic>);
    } else {
      return HttpBaseResponse(
          code: 500, message: "Error de conexión", data: null);
    }
  } on Exception {
    return HttpBaseResponse(code: 1, message: "Error en la data", data: null);
  }
}

Future<String> listarDiagnosticos(String idUser) async {
  try {
    final response = await api.post('/findHistory', {"idUser": idUser});
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      return 'Coneption error';
    }
  } on Exception {
    return 'Internal error';
  }
}

Future<HttpBaseResponse> DoctorName(String idUser) async {
  try {
    final response = await api.post('/findUserforDoctor', {"idDoctor": idUser});
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return HttpBaseResponse.fromJson(decodedData as Map<String, dynamic>);
    } else {
      return HttpBaseResponse(
          code: 500, message: "Error de conexión", data: null);
    }
  } on Exception {
    return HttpBaseResponse(code: 1, message: "Error en la data", data: null);
  }
}
