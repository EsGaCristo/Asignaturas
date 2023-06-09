import 'package:dam_u4_proyecto2/modelos/asignacion.dart';
import 'package:dam_u4_proyecto2/services/firebase_service.dart';
import 'package:flutter/material.dart';

class UpdateAsignacion extends StatefulWidget {
  const UpdateAsignacion({Key? key}) : super(key: key);

  @override
  State<UpdateAsignacion> createState() => _UpdateAsignacionState();
}

class _UpdateAsignacionState extends State<UpdateAsignacion> {
  final docenteController = TextEditingController();
  final edificioController = TextEditingController();
  final horarioController = TextEditingController();
  final materiaController = TextEditingController();
  final salonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    docenteController.text = arguments['docente'];
     edificioController.text = arguments['edificio'];
     horarioController.text = arguments['horario'];
     materiaController.text = arguments['materia'];
     salonController.text  = arguments['salon'];

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
          TextField(
            controller: horarioController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Horario"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: docenteController,
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
                  docente: docenteController.text,
                  materia: materiaController.text,
                );
                await updateAsignacion(arguments['id'] ,veh).then((value) => {
                      if (value > 0)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("SE ACTUALIZO CON EXITO"))),
                        }
                    });
                docenteController.clear();
                materiaController.clear();
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
