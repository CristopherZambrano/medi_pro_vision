class HttpBaseResponse {
  int code;
  dynamic data;

  HttpBaseResponse({
    required this.code,
    required this.data,
  });

  factory HttpBaseResponse.fromJson(Map<String, dynamic> json) =>
      HttpBaseResponse(code: json['code'], data: json['data']);

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data.toJson(),
      };
}
