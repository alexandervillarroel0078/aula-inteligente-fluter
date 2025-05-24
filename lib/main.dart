import 'package:flutter/material.dart';
import 'screens/check_auth_screen.dart';
//import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

import 'screens/materias/materias_screen.dart';
import 'screens/perfil/perfil_screen.dart';
import 'screens/tareas/tareas_screen.dart';
import 'screens/pantalla_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aula Inteligente',
      initialRoute: '/',
      routes: {
        '/': (context) => const CheckAuthScreen(),
        '/login': (context) => LoginScreen(),
        // '/home': (context) => HomeScreen(),
        '/home': (context) => const PantallaPrincipal(),
        '/materias': (context) => MateriasScreen(),
        // '/perfil': (context) => PerfilScreen(),
        '/tareas': (context) => TareasScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/perfil') {
          final args = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => PerfilScreen(alumnoId: args),
          );
        }
        return null;
      },
    );
  }
}
