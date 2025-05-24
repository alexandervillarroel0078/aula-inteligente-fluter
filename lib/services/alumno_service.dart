import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/alumno.dart';

class AlumnoService {
  final String baseUrl = AppConfig.baseUrl;

  Future<List<Alumno>> obtenerAlumnos() async {
    final response = await http.get(Uri.parse('$baseUrl/api/alumnos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Alumno.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener alumnos');
    }
  }

  Future<Alumno> obtenerAlumno(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/api/alumnos/$id'));

    if (response.statusCode == 200) {
      return Alumno.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener alumno');
    }
  }

  Future<Alumno> crearAlumno(Alumno alumno) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/alumnos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(alumno.toJson()),
    );

    if (response.statusCode == 200) {
      return Alumno.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear alumno');
    }
  }

  Future<bool> editarAlumno(int id, Alumno alumno) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/alumnos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(alumno.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<bool> eliminarAlumno(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/api/alumnos/$id'));
    return response.statusCode == 200;
  }

  Future<Alumno> obtenerPerfil(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/alumnos/$id/perfil'),
    );
    if (response.statusCode == 200) {
      return Alumno.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener perfil');
    }
  }

  Future<List<dynamic>> obtenerNotas(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/alumnos/$id/notas'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener notas');
    }
  }

  Future<List<dynamic>> obtenerAsistencias(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/alumnos/$id/asistencias'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener asistencias');
    }
  }

  Future<List<dynamic>> obtenerParticipaciones(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/alumnos/$id/participaciones'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener participaciones');
    }
  }

  Future<List<dynamic>> obtenerPredicciones(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/alumnos/$id/predicciones'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener predicciones');
    }
  }

  Future<List<dynamic>> obtenerHistorial(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/alumnos/$id/historial'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener historial');
    }
  }

  Future<List<dynamic>> obtenerMaterias(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/alumnos/$id/materias'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener materias');
    }
  }
}
