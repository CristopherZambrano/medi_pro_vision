class ListaDiagnosis {
  int idDiagnosis;
  String diagnostico;
  String fecha;
  String doctor;

  ListaDiagnosis({
    required this.idDiagnosis,
    required this.diagnostico,
    required this.fecha,
    required this.doctor,
  });

  // Método factory para crear una instancia de ListaDiagnosis desde un mapa
  factory ListaDiagnosis.fromJson(Map<String, dynamic> json) {
    return ListaDiagnosis(
      idDiagnosis: json['idDiagnosis'],
      diagnostico: json['Diagnostico'],
      fecha: json['Fecha'],
      doctor: json['Doctor'],
    );
  }
}
