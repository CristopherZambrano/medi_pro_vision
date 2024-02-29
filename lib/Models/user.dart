class HttpBaseResponse {
  int code;
  dynamic data;
  String message;

  HttpBaseResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory HttpBaseResponse.fromJson(Map<String, dynamic> json) =>
      HttpBaseResponse(
          code: json['code'], message: json['message'], data: json['data']);

  Map<String, dynamic> toJson() => {
        'code': code,
        'massage': message,
        'data': data.toJson(),
      };
}
