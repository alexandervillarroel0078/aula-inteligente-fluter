// lib/screens/pantalla_principal.dart

import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'dashboard/dashboard_screen.dart';
import 'materias/materias_screen.dart';
import 'tareas/tareas_screen.dart';
import 'perfil/perfil_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _selectedIndex = 0;
  int? alumnoId;

  @override
  void initState() {
    super.initState();
    _cargarAlumnoId();
  }

  void _cargarAlumnoId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('alumnoId');
    if (id != null) {
      setState(() {
        alumnoId = id;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (alumnoId == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Cargando datos del estudiante..."),
            ],
          ),
        ),
      );
    }

    final List<Widget> _pantallas = [
      DashboardScreen(),
      MateriasScreen(),
      TareasScreen(),
      PerfilScreen(alumnoId: alumnoId!), // ✅ correcto
    ];

    return Scaffold(
      body: _pantallas[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
