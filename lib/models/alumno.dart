import 'package:intl/intl.dart';

class Alumno {
  final int id;
  final String codigo;
  final String nombreCompleto;
  final DateTime fechaNacimiento;
  final String genero;
  final DateTime? fechaRegistro;
  final String estado;
  final String email;
  final String telefono;
  final String direccion;
  final int gradoId;
  final String? gradoNombre; // opcional si traes también el nombre del grado

  Alumno({
    required this.id,
    required this.codigo,
    required this.nombreCompleto,
    required this.fechaNacimiento,
    this.fechaRegistro,
    required this.genero,
    required this.estado,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.gradoId,
    this.gradoNombre,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) {
    return Alumno(
      id: json['id'],
      codigo: json['codigo'],
      nombreCompleto: json['nombre_completo'],
      fechaNacimiento: _parseFecha(json['fecha_nacimiento']),
      genero: json['genero'],
      fechaRegistro: json['fecha_registro'] != null
          ? _parseFecha(json['fecha_registro']) // ✅ esta línea
          : null,

      estado: json['estado'],
      email: json['email'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      gradoId: json['grado_id'],
      gradoNombre: json['grado_nombre'], // si lo incluyes en tu API
    );
  }
  static DateTime _parseFecha(String raw) {
    try {
      return DateFormat(
        "EEE, dd MMM yyyy HH:mm:ss 'GMT'",
        "en_US",
      ).parseUtc(raw).toLocal();
    } catch (e) {
      print("Error al parsear fecha: $e");
      return DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'nombre_completo': nombreCompleto,
      'fecha_nacimiento': fechaNacimiento.toIso8601String(),
      'genero': genero,
      'fecha_registro': fechaRegistro?.toIso8601String(),
      'estado': estado,
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
      'grado_id': gradoId,
      'grado_nombre': gradoNombre,
    };
  }
}
