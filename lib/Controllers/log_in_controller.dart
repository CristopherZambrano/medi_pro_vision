import 'dart:convert';
import 'package:medi_pro_vision/Global/api_interceptors.dart';
import 'package:medi_pro_vision/Models/user.dart';

final ApiInterceptor api = ApiInterceptor();

Future<HttpBaseResponse> checkCredencials(String user, String password) async {
  try {
    final response = await api.post('/finduser', {
      'user': user,
      'password': password,
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

Future<int> verifyTipeUser(int id) async {
  try {
    final response = await api.post("/tipeUser", {'id': id.toString()});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return 0;
    }
  } on Exception {
    return 0;
  }
}
