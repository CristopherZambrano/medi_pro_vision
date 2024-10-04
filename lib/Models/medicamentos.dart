import 'package:flutter/material.dart';

class Medicine {
  int id;
  String tradeName;
  String genericName;
  String presentation;

  Medicine(
      {required this.id,
      required this.tradeName,
      required this.genericName,
      required this.presentation});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
        id: json['id'],
        tradeName: json['tradeName'],
        genericName: json['genericName'],
        presentation: json['presentation']);
  }
}
