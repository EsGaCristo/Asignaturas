import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/firebase_service.dart';

class Pagina3 extends StatefulWidget {
  @override
  _Pagina3State createState() => _Pagina3State();
}

class _Pagina3State extends State<Pagina3> {
  final edificioController = TextEditingController();
  final fechaController = TextEditingController();
  final horarioController = TextEditingController();
  Future<List<dynamic>>? _futureAsistencias;

  @override
  void dispose() {
    edificioController.dispose();
    fechaController.dispose();
    horarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        TextField(
            controller: edificioController,
            decoration: InputDecoration(
                labelText: "Edificio", border: OutlineInputBorder())),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: fechaController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Fecha Inicio",
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () async {
            final DateTime? selectedDateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDateTime != null) {
              final TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                final DateTime combinedDateTime = DateTime(
                  selectedDateTime.year,
                  selectedDateTime.month,
                  selectedDateTime.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                setState(() {
                  fechaController.text =
                      DateFormat('dd/MM/yyyy HH:mm').format(combinedDateTime);
                });
              }
            }
          },
          readOnly: true, // Evita que el usuario escriba la fecha manualmente
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: horarioController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Fecha",
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () async {
            final DateTime? selectedDateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDateTime != null) {
              final TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                final DateTime combinedDateTime = DateTime(
                  selectedDateTime.year,
                  selectedDateTime.month,
                  selectedDateTime.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                setState(() {
                  horarioController.text =
                      DateFormat('dd/MM/yyyy HH:mm').format(combinedDateTime);
                });
              }
            }
          },
          readOnly: true, // Evita que el usuario escriba la fecha manualmente
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              /*            _futureAsistencias = getAsistenciaPorFechasEdificio(
                  fechaController.text, horarioController.text,edificioController.text);
*/

              getAsistenciaPorFechasEdificio(fechaController.text,
                  horarioController.text, edificioController.text);
            });
          },
          child: Icon(Icons.graphic_eq_outlined),
        ),
        //_buildFutureBuilder(),
      ],
    );
  }

  Widget _buildFutureBuilder() {
    return _futureAsistencias != null
        ? FutureBuilder<List<dynamic>>(
            future: _futureAsistencias,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      'Error al obtener las asistencias: ${snapshot.error}'),
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
                      title: Text("Reviso: " + asistencia['revisor'] ?? ''),
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
