import 'package:dam_u4_proyecto2/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Programa extends StatefulWidget {
  const Programa({Key? key}) : super(key: key);

  @override
  State<Programa> createState() => _ProgramaState();
}

class _ProgramaState extends State<Programa> {
  String selectedMonth = 'Enero';
/*
  List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asignaturas y asistencias"),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(
                  context,
                  '/consultas',
                );
                setState(() {});
              },
              icon: Icon(Icons.find_replace_outlined)),

        ],
      ),
      body: FutureBuilder(
          future: getAsignaciones(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: Text("ATENCION"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Navigator.pushNamed(
                                          context, '/update',
                                          arguments: snapshot.data?[index]);
                                      setState(() {});
                                    },
                                    child: Text("ACTUALIZAR")),
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Navigator.pushNamed(
                                          context, '/asistencia',
                                          arguments: snapshot.data?[index]
                                          ['id']);
                                      setState(() {});
                                    },
                                    child: Text("ASISTENCIAS")),
                                TextButton(
                                    onPressed: () {
                                      //print(snapshot.data?[index]['id']);
                                      deleteVehiculo(snapshot.data![index]['id']
                                          .toString())
                                          .then((value) => {
                                        if (value > 0)
                                          {
                                            ScaffoldMessenger.of(
                                                context)
                                                .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Se elimino exitosamente")))
                                          }
                                      });
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Text("ELIMINAR")),
                              ],
                            );
                          });
                    },
                    child: ExpansionTile(
                      title: Text("Materia: "+snapshot.data?[index]['materia']),
                      subtitle: Text("Docente: "+snapshot.data?[index]['docente']),
                      trailing: Text("Horario: "+snapshot.data?[index]['horario']),
                      leading: Text("Salon: "+snapshot.data?[index]['salon']),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Departamento: " +
                                  snapshot.data?[index]['edificio']),
                            ],
                          ),
                        ),
                      ],
                    ),

                  );
                  return Text(snapshot.data?[index]['placa']);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: Icon(Icons.add),
      ),




    );
  }
}
