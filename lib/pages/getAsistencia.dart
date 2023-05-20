import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class GetAsistencia extends StatefulWidget {
  const GetAsistencia({Key? key}) : super(key: key);

  @override
  State<GetAsistencia> createState() => _GetAsistenciaState();
}

class _GetAsistenciaState extends State<GetAsistencia> {
  @override
  Widget build(BuildContext context) {
    final String argument = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("ASISTENCIAS "),
      ),
      body: FutureBuilder(
          future: getAsistencia(argument),
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
                                          context, '/updateBitacora',
                                          arguments: {
                                            'arg1': snapshot.data?[index],
                                            'arg2': argument,
                                          });
                                      setState(() {});
                                    },
                                    child: Text("ACTUALIZAR")),
                              ],
                            );
                          });

                    },
                    child: ListTile(
                      title: Text("Fecha: "+ snapshot.data?[index]['fecha']),
                      subtitle: Text("Revisor: "+snapshot.data?[index]['revisor']),
                    ),
                  );
                  //return Text(snapshot.data?[index]['placa']);
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
          await Navigator.pushNamed(context, '/addAsistencia',arguments: argument);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
