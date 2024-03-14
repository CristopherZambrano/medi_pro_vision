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
}
