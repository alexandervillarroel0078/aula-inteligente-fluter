// lib/controllers/perfil_controller.dart
import '../../models/alumno.dart';
import '../../services/alumno_service.dart';

class PerfilController {
  final AlumnoService _alumnoService = AlumnoService();

  Future<Alumno> obtenerPerfil(int alumnoId) {
    return _alumnoService.obtenerPerfil(alumnoId);
  }
}
