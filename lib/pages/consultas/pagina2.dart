import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class Pagina2 extends StatefulWidget {
  @override
  _Pagina2State createState() => _Pagina2State();
}

class _Pagina2State extends State<Pagina2> {
  final fechaController = TextEditingController();
  Future<List<dynamic>>? _futureAsistencias;

  @override
  void dispose() {
    fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        TextField(controller: fechaController, decoration: InputDecoration(labelText: "Revisor")),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAsistencias = getAsistenciaPorRevisor(fechaController.text);
            });
          },
          child: Icon(Icons.graphic_eq_outlined),
        ),
        _buildFutureBuilder(),
      ],
    );
  }

  Widget _buildFutureBuilder() {
    return _futureAsistencias != null
        ? FutureBuilder<List<dynamic>>(
      future: _futureAsistencias,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error al obtener las asistencias: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          List<dynamic> asistencias = snapshot.data!;
          if (asistencias.isEmpty) {
            return const Center(
              child: Text('No hay asistencias disponibles'),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: asistencias.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> asistencia = asistencias[index];
              return ListTile(
                title: Text("Reviso: "+asistencia['revisor'] ?? ''),
                subtitle: Text("fecha: " + asistencia['fecha'] ?? ''),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No hay asistencias disponibles'),
          );
        }
      },
    )
        : Container();
  }
}
