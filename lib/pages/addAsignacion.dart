import 'package:dam_u4_proyecto2/modelos/asignacion.dart';
import 'package:dam_u4_proyecto2/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAsignacion extends StatefulWidget {
  const AddAsignacion({Key? key}) : super(key: key);

  @override
  State<AddAsignacion> createState() => _AddAsignacionState();
}

class _AddAsignacionState extends State<AddAsignacion> {
  var _selectedFuelType;

  var _selectedType;

  final docenteController = TextEditingController();
  final edificioController = TextEditingController();
  final horarioController = TextEditingController();
  final materiaController = TextEditingController();
  final salonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar asignatura nueva"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [

          SizedBox(
            height: 10,
          ),
          TextField(
            controller: salonController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Aula"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: edificioController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Edificio"),
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
                  horarioController.text = DateFormat('dd/MM/yyyy HH:mm').format(combinedDateTime);
                }
              }
            },
            readOnly: true, // Evita que el usuario escriba la fecha manualmente
          ),


          SizedBox(
            height: 10,
          ),
          TextField(
            controller: docenteController ,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Docente"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            //keyboardType: TextInputType.number,
            controller: materiaController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Materia"),
          ),
          SizedBox(
            height: 10,
          ),

          SizedBox(
            height: 10,
          ),
          FilledButton(
              onPressed: () async {
                Asignacion veh = Asignacion(
                    salon: salonController.text,
                    edificio: edificioController.text,
                    horario: horarioController.text,
                    docente:docenteController.text,
                    materia: materiaController.text,);
                await addAsignacion(veh).then((value) => {
                      if (value > 0)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("SE INSERTO CON EXITO"))),
                        }
                    });
                 docenteController.clear();
                 materiaController.clear() ;
                 edificioController.clear();
                 horarioController.clear();
                 salonController.clear();
                Navigator.pop(context);
              },
              child: Text("Guardar"))
        ],
      ),
    );
  }
}
