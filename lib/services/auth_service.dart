import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final storage = const FlutterSecureStorage();

  Future<bool> login(String correo, String password) async {
    final url = Uri.parse('${AppConfig.baseUrl}/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'correo': correo, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Guardar el token y algunos datos del usuario
      await storage.write(key: 'token', value: data['token']);
      await storage.write(
        key: 'nombre_usuario',
        value: data['usuario']['nombre_usuario'],
      );
      await storage.write(key: 'rol', value: data['usuario']['rol']);
      await storage.write(key: 'correo', value: data['usuario']['correo']);

      await guardarAlumnoId(data['usuario']['id']);
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout() async {
    await storage.deleteAll();
  }

  Future<Map<String, String?>> getUserInfo() async {
    final nombre = await storage.read(key: 'nombre_usuario');
    final rol = await storage.read(key: 'rol');
    final correo = await storage.read(key: 'correo');
    return {'nombre_usuario': nombre, 'rol': rol, 'correo': correo};
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<int?> obtenerAlumnoId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('alumnoId');
  }

  Future<void> guardarAlumnoId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('alumnoId', id);
  }
}
