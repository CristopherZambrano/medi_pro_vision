class HttpBaseResponse {
  int code;
  dynamic data;

  HttpBaseResponse({
    required this.code,
    required this.data,
  });

  factory HttpBaseResponse.fromJson(Map<String, dynamic> json) =>
      HttpBaseResponse(code: json['code'], data: json['Detalle']);

  Map<String, dynamic> toJson() => {
        'code': code,
        'detalle': data.toJson(),
      };
}
