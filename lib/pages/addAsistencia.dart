import 'package:dam_u4_proyecto2/modelos/asistencia.dart';
import 'package:dam_u4_proyecto2/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAsistencia extends StatefulWidget {
  const AddAsistencia({Key? key}) : super(key: key);

  @override
  State<AddAsistencia> createState() => _AddAsistenciaState();
}

class _AddAsistenciaState extends State<AddAsistencia> {
  final revisorController = TextEditingController();
  final fechaController = TextEditingController();
  final idasistenciaController = TextEditingController();
  final horaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final String argument =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Bitacora"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: idasistenciaController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Id asistencia"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: revisorController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Revisor"),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: fechaController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Fecha",
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode()); // Quita el foco del teclado
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
                  fechaController.text = DateFormat('dd/MM/yyyy HH:mm').format(combinedDateTime);
                }
              }
            },
            readOnly: true, // Evita que el usuario escriba la fecha manualmente
          ),
          SizedBox(
            height: 10,
          ),
          FilledButton(
              onPressed: () async {
                Asistencia veh = Asistencia(
                  idasistencia: idasistenciaController.text,
                  fecha: fechaController.text,
                  revisor: revisorController.text,
                );
                await addAsistencia(argument,veh).then((value) => {
                      if (value > 0)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("SE INSERTO CON EXITO"))),
                        }
                    });
                revisorController.clear();
                fechaController.clear();
                Navigator.pop(context);
              },
              child: Text("Guardar"))
        ],
      ),
    );
  }
}
