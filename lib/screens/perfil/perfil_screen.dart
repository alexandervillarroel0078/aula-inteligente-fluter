import 'package:flutter/material.dart';
import '../../controllers/perfil_controller.dart';
import '../../models/alumno.dart';
import 'editar_foto.dart'; // si lo tienes
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PerfilScreen extends StatefulWidget {
  final int alumnoId;

  const PerfilScreen({Key? key, required this.alumnoId}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final PerfilController _controller = PerfilController();
  late Future<Alumno> _futurePerfil;

  @override
  void initState() {
    super.initState();
    _futurePerfil = _controller.obtenerPerfil(widget.alumnoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final storage = FlutterSecureStorage();
              await storage.delete(
                key: 'token',
              ); // o el nombre de tu clave de sesión
              await storage.deleteAll(); // opcional: borra todo lo guardado

              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/login', (route) => false);
            },
          ),
        ],
      ),
      body: FutureBuilder<Alumno>(
        future: _futurePerfil,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Perfil no encontrado.'));
          }

          final alumno = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        alumno.nombreCompleto.substring(0, 1),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: EditarFotoButton(), // si usas esta funcionalidad
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  alumno.nombreCompleto,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text(alumno.email)),
              const Divider(height: 35),
              const Text(
                "Información personal:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              buildInfoRow("Código", alumno.codigo),
              buildInfoRow("Teléfono", alumno.telefono),
              buildInfoRow("Dirección", alumno.direccion),
              buildInfoRow(
                "Nacimiento",
                alumno.fechaNacimiento.toLocal().toString().split(' ')[0],
              ),
              buildInfoRow("Género", alumno.genero),
              buildInfoRow("Grado", alumno.gradoNombre ?? 'Sin grado'),
              buildInfoRow("Estado", alumno.estado),
            ],
          );
        },
      ),
    );
  }

  Widget buildInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.arrow_right, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(child: Text('$title: ${value ?? 'No disponible'}')),
        ],
      ),
    );
  }
}
