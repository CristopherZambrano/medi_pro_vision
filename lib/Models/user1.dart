class User {
  int id;
  String nombre;
  String apellido;
  String email;
  String fechaNacimiento;
  String password;
  String genero;
  String direccion;
  String celular;
  String documento;

  User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.fechaNacimiento,
    required this.password,
    required this.genero,
    required this.direccion,
    required this.celular,
    required this.documento,
  });

  // Método para convertir los datos del usuario a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'fechaNacimiento': fechaNacimiento,
      'password': password,
      'genero': genero,
      'direccion': direccion,
      'celular': celular,
      'documento': documento,
    };
  }

  // Método para construir un objeto User a partir de un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json['email'],
      fechaNacimiento: json['fechaNacimiento'],
      password: json['password'],
      genero: json['genero'],
      direccion: json['direccion'],
      celular: json['celular'],
      documento: json['documento'],
    );
  }

  User parseUserString(String userString) {
    List<String> parts = userString.split(', ');
    int id = int.parse(parts[0].substring(parts[0].indexOf('=') + 1));
    String nombre = parts[1].substring(parts[1].indexOf('=') + 1);
    String apellido = parts[2].substring(parts[2].indexOf('=') + 1);
    String email = parts[3].substring(parts[3].indexOf('=') + 1);
    String fechaNacimiento = parts[4].substring(parts[4].indexOf('=') + 1);
    String password = parts[5].substring(parts[5].indexOf('=') + 1);
    String genero = parts[6].substring(parts[6].indexOf('=') + 1);
    String direccion = parts[7].substring(parts[7].indexOf('=') + 1);
    String celular = parts[8].substring(parts[8].indexOf('=') + 1);
    String documento =
        parts[9].substring(parts[9].indexOf('=') + 1, parts[9].length - 1);

    return User(
      id: id,
      nombre: nombre,
      apellido: apellido,
      email: email,
      fechaNacimiento: fechaNacimiento,
      password: password,
      genero: genero,
      direccion: direccion,
      celular: celular,
      documento: documento,
    );
  }
}
