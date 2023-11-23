import 'package:http/http.dart' as http;
import 'package:medi_pro_vision/Global/coneption.dart';

class ApiInterceptor {
  final String apiUrl = ApiConsume.urlApi;

  final Map<String, String> defaultHeaders = {};

  Future<http.Response> get(String url) async {
    return http.get(Uri.parse(apiUrl + url), headers: defaultHeaders);
  }

  Future<http.Response> post(String url, dynamic body) async {
    return http.post(Uri.parse(apiUrl + url),
        headers: defaultHeaders, body: body);
  }

  Future<http.Response> put(String url, dynamic body) async {
    return http.put(Uri.parse(apiUrl + url),
        headers: defaultHeaders, body: body);
  }

  Future<http.Response> delete(String url) async {
    return http.delete(Uri.parse(apiUrl + url), headers: defaultHeaders);
  }
}
