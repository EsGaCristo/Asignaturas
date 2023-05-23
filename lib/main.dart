import 'package:dam_u4_proyecto2/pages/getAsistencia.dart';
import 'package:dam_u4_proyecto2/pages/addAsignacion.dart';
import 'package:dam_u4_proyecto2/pages/addAsistencia.dart';
import 'package:dam_u4_proyecto2/pages/getConsultas.dart';
import 'package:dam_u4_proyecto2/pages/updateAsignacion.dart';
import 'package:dam_u4_proyecto2/programa.dart';
import 'package:dam_u4_proyecto2/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>Programa(),
        '/add':(context) => AddAsignacion(),
        '/update':(context) => UpdateAsignacion(),
        '/asistencia':(context)=>GetAsistencia(),
        '/addAsistencia':(context)=> AddAsistencia(),
        '/consultas':(context)=> GetConsultas(),
      },

      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
