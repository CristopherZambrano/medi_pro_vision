import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:medi_pro_vision/Global/api_interceptors.dart';
import 'package:medi_pro_vision/Models/detailTreatment.dart';
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

void guardarTratamiento(int idDiagnosis, Map<String, dynamic> detalle) async {
  try {
    bool esFarmacologico =
        detalle['medication'].isNotEmpty || detalle['insulinDose'] > 0;
    DateTime? ultimaFechaFin;
    if (detalle['medication'].isNotEmpty) {
      ultimaFechaFin = detalle['medication']
          .map((med) => DateTime.parse(med['fecha_fin']))
          .reduce((fecha1, fecha2) => fecha1.isAfter(fecha2) ? fecha1 : fecha2);
    }
    final tratamientoData = {
      "idDiagnosis": idDiagnosis.toString(),
      if (ultimaFechaFin != null)
        "fechaFin": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(ultimaFechaFin),
      "farmacologico": esFarmacologico.toString(),
    };
    final tratamientoResponse =
        await api.post('/newTreatment', tratamientoData);
    if (tratamientoResponse.statusCode == 200) {
      print("Aqui llego");
      final decodedData = jsonDecode(tratamientoResponse.body);
      print(decodedData);
      int idTreatment = int.parse(decodedData['id'].toString());
      if (esFarmacologico) {
        for (var med in detalle['medication']) {
          print(med.toString());
          final medicamentoData = {
            "idTreatment": idTreatment.toString(),
            "idMedicine": med['id_medicina'].toString(),
            "dosis": med['dosis'].toString(),
            "frecuencia": med['frecuencia'].toString(),
            "startDate": med['fecha_inicio'].toString(),
            "endDate": med['fecha_fin'].toString(),
          };
          print(medicamentoData);
          final medicamentoResponse =
              await api.post('/detailTreatment', medicamentoData);
          if (medicamentoResponse.statusCode != 200) {
            print(
                "Error al guardar el medicamento: ${medicamentoResponse.statusCode}");
          }
        }
      }
      print("Tratamiento guardado con éxito.");
    } else {
      print(
          "Error al guardar el tratamiento: ${tratamientoResponse.statusCode}");
      throw Exception(
          "Error en la solicitud de tratamiento: ${tratamientoResponse.statusCode}");
    }
  } catch (e) {
    print("Ocurrió un error al guardar el tratamiento: $e");
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
