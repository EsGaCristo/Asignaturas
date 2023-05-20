import 'package:dam_u4_proyecto2/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Programa extends StatefulWidget {
  const Programa({Key? key}) : super(key: key);

  @override
  State<Programa> createState() => _ProgramaState();
}

class _ProgramaState extends State<Programa> {
  String selectedMonth = 'Enero';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autos Ittepic"),
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(
                  context,
                  '/bitacoraVerificacion',
                );
                setState(() {});
              },
              icon: Icon(Icons.find_replace_outlined)),
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return AlertDialog(
                        title: Text("ATENCION"),
                        actions: [
                          DropdownButton<String>(
                            value: selectedMonth,
                            hint: Text('Selecciona un mes'),
                            onChanged: (value) {
                              setState(() {
                                selectedMonth = value!;
                              });
                            },
                            items: months.map((month) {
                              return DropdownMenuItem<String>(
                                value: month,
                                child: Text(month),
                              );
                            }).toList(),
                          ),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await Navigator.pushNamed(
                                  context,
                                  '/bitacoraFecha',
                                  arguments: selectedMonth,
                                );
                                setState(() {});
                              },
                              child: Text("Revisar Bitacoras"))
                        ],
                      );
                    });
              },
              icon: Icon(Icons.date_range)),
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
                      title: Text(snapshot.data?[index]['materia']),
                      subtitle: Text(snapshot.data?[index]['docente']),
                      trailing: Text(snapshot.data?[index]['horario']),
                      leading: Text(snapshot.data?[index]['salon']),
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
