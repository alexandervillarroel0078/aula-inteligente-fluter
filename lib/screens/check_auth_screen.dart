import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'pantalla_principal.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});
  Future<bool> verificarSesion() async {
    final auth = AuthService();
    final token = await auth.getToken();
    //final alumnoId = await auth.obtenerAlumnoId();
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: verificarSesion(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          Future.microtask(
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PantallaPrincipal()),
            ),
          );
        } else {
          Future.microtask(
            () => Navigator.pushReplacementNamed(context, '/login'),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
