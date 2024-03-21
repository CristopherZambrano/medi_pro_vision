class Diagnosis {
  int id;
  int idRecord;
  String dateDiagnosis;
  String diagnosis;
  int idDoctor;

  Diagnosis({
    required this.id,
    required this.idRecord,
    required this.dateDiagnosis,
    required this.diagnosis,
    required this.idDoctor,
  });

  // Método estático para analizar y mapear la cadena a una instancia de Diagnosis
  static Diagnosis fromString(String input) {
    // Eliminar los caracteres no deseados de la cadena
    String cleanedInput = input.replaceAll(RegExp(r'[()]'), '');

    // Dividir la cadena en partes usando la coma como delimitador
    List<String> parts = cleanedInput.split(', ');

    // Parsear cada parte y extraer los valores
    int id = int.parse(parts[0].split('=')[1]);
    int idRecord = int.parse(parts[1].split('=')[1]);
    String dateDiagnosis = parts[2].split('=')[1];
    String diagnosis = parts[3].split('=')[1];
    int idDoctor = int.parse(parts[4].split('=')[1]);

    // Retornar una nueva instancia de Diagnosis con los valores extraídos
    return Diagnosis(
      id: id,
      idRecord: idRecord,
      dateDiagnosis: dateDiagnosis,
      diagnosis: diagnosis,
      idDoctor: idDoctor,
    );
  }

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: int.parse(json['id'].toString()),
      idRecord: int.parse(json['idRecord'].toString()),
      dateDiagnosis: json['date'].toString(),
      diagnosis: json['diagnosis'].toString(),
      idDoctor: int.parse(json['idDoctor'].toString()),
    );
  }
}
