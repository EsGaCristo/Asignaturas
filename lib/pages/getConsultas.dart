import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/firebase_service.dart';
import 'consultas/pagina1.dart';
import 'consultas/pagina2.dart';
import 'consultas/pagina3.dart';

class GetConsultas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GetConsultasState();
  }
}

class _GetConsultasState extends State<GetConsultas> {
  int _indice = 0;

  final List<String> _routes = [
    '/pagina1',
    '/pagina2',
    '/pagina3',
    '/atras',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consultas")),
      body: _buildPage(_indice),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_rounded), label: "Rango de fechas"),
          BottomNavigationBarItem(icon: Icon(Icons.query_stats_sharp), label: "Rango de fechas y edificio"),
          BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined), label: "Revisor"),
          BottomNavigationBarItem(icon: Icon(Icons.reset_tv), label: "Atras"),
        ],
        backgroundColor: Colors.blueGrey,
        currentIndex: _indice,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        onTap: (int i) {
          if (i != _indice) {
            setState(() {
              _indice = i;
            });
          } else if (i == 3) {
            Navigator.pushNamed(context,'/');  // Regresar a la pantalla anterior
          }
        },
        iconSize: 30,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (_routes[index]) {
      case '/pagina1':
        return Pagina1();
      case '/pagina2':
        return Pagina2();
      case '/pagina3':
        return Pagina3();
      default:
        return Container();
    }
  }
}
