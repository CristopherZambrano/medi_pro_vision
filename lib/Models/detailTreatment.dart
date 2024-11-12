class SelectedMedication {
  final int idMedicina;
  final String dosis;
  final String frecuencia;
  final DateTime fechaInicio;
  final DateTime fechaFin;

  SelectedMedication({
    required this.idMedicina,
    required this.dosis,
    required this.frecuencia,
    required this.fechaInicio,
    required this.fechaFin,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_medicina': idMedicina,
      'dosis': dosis,
      'frecuencia': frecuencia,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_fin': fechaFin.toIso8601String(),
    };
  }
}
