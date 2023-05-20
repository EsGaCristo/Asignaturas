import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2/modelos/asignacion.dart';
import 'package:dam_u4_proyecto2/modelos/asistencia.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

/*** Obtencion de vehiculos ***/

Future<List> getAsignaciones() async {
  List asignaciones = [];
  try {
    CollectionReference collectionReferenceAsignacion = db.collection('asignacion');
    QuerySnapshot queryAsignacion = await collectionReferenceAsignacion.get();
    queryAsignacion.docs.forEach((document) {
      Map<String, dynamic>? asignacionData =
          document.data() as Map<String, dynamic>?;
      asignacionData?['id'] = document.id; // agregar el ID al mapa de datos
      asignaciones.add(asignacionData);
    });
  } catch (e) {}
  await Future.delayed(const Duration(seconds: 1));
  return asignaciones;
} //Fin del retorno de vehiculos


/*** Agregar Asignatura ***/
Future<int> addAsignacion(Asignacion asignacion) async {
  try {
    await db.collection("asignacion").add(asignacion.toMap());
    return 1; // se realizó la inserción exitosamente
  } catch (e) {
    print('Error al agregar asignatura: $e');
    return -1; // ocurrió un error al insertar
  }
}

/*** Actualizar Asignatura ***/

Future<int> updateAsignacion(String uid, Asignacion asignacion) async {
  try {
    await db.collection("asignacion").doc(uid).set(asignacion.toMap());
    return 1;
  } catch (e) {
    print('Error al agregar vehículo: $e');
    return -1; // ocurrió un error al insertar
  }
}

/*** Eliminar Asignacion ***/
Future<int> deleteVehiculo(String uid) async {
  try {
    await db.collection("asignacion").doc(uid).delete();
    return 1; // se eliminó el vehículo exitosamente
  } catch (e) {
    print('Error al eliminar vehículo: $e');
    return -1; // ocurrió un error al eliminar
  }
}

/*** Obtencion de asistencia ***/
Future<List> getAsistencia(String uid) async {
  List asistencias = [];
  try {
    DocumentSnapshot asistenciaBitacoraSnapshot =
        await db.collection('asignacion').doc(uid).get();
    Map<String, dynamic>? asignacionAsistencia =
    asistenciaBitacoraSnapshot.data() as Map<String, dynamic>?;
    if (asignacionAsistencia != null && asignacionAsistencia.containsKey('Asistencia')) {
      asistencias =
          List<Map<String, dynamic>>.from(asignacionAsistencia['Asistencia'].values);
    }
  } catch (e) {
    print(e);
  }

  await Future.delayed(const Duration(seconds: 1));
  return asistencias;
}
/***
/*** Obtencion de bitacoras por mes  ***/
Future<List> getBitacorasPorMes(String mes) async {
  int? numeroMes = obtenerNumeroMes(mes);
  List bitacoras = [];

  try {
    QuerySnapshot vehiculosSnapshot = await db.collection('vehiculo').get();
    for (var vehiculoDoc in vehiculosSnapshot.docs) {
      DocumentSnapshot vehiculoBitacoraSnapshot =
          await vehiculoDoc.reference.get();
      Map<String, dynamic>? vehiculoBitacora =
          vehiculoBitacoraSnapshot.data() as Map<String, dynamic>?;

      if (vehiculoBitacora != null &&
          vehiculoBitacora.containsKey('Bitacora')) {
        List<Map<String, dynamic>> bitacorasVehiculo =
            List<Map<String, dynamic>>.from(
                vehiculoBitacora['Bitacora'].values);

        for (var bitacora in bitacorasVehiculo) {
          String fechaString = bitacora['fecha'];
          DateTime fecha = DateFormat('dd/MM/yyyy').parse(fechaString);

          if (fecha.month == numeroMes) {
            bitacoras.add(bitacora);
          }
        }
      }
    }
  } catch (e) {
    print(e);
  }

  await Future.delayed(const Duration(seconds: 1));
  return bitacoras;
}

/***Obtencion de bitacoras que tengan la fecha verificacion vacia ***/
Future<List<dynamic>?> getBitacorasFechaverificacion() async {
  List<dynamic> bitacoras = [];

  try {
    QuerySnapshot vehiculosSnapshot = await db.collection('vehiculo').get();
    for (var vehiculoDoc in vehiculosSnapshot.docs) {
      DocumentSnapshot vehiculoSnapshot = await vehiculoDoc.reference.get();
      Map<String, dynamic>? vehiculoData = vehiculoSnapshot.data() as Map<String, dynamic>?;

      if (vehiculoData != null && vehiculoData.containsKey('Bitacora')) {
        List<dynamic> bitacorasVehiculo = vehiculoData['Bitacora'].values.toList();

        for (var bitacora in bitacorasVehiculo) {
          if (bitacora['fechaverificacion'] == null || bitacora['fechaverificacion'] == '') {
            bitacoras.add(bitacora);
          }
        }
      }
    }
  } catch (e) {
    print(e);
  }

  await Future.delayed(const Duration(seconds: 1));
  return bitacoras;
}
***/
/*** Agregar Asistencias ***/
Future<int> addAsistencia(String uid, Asistencia asistencia) async {
  String idB = asistencia.idasistencia;
  try {
    var asignacionRef = db.collection("asignacion").doc(uid);
    var asignacionDoc = await asignacionRef.get();
    if (!asignacionDoc.exists) {
      // Si el documento del vehículo no existe, crear uno nuevo
      await asignacionRef.set({
        'Asistencia': {
          idB: asistencia.toMap(),
        },
      });
    } else {
      // Si el documento del vehículo existe, actualizar la matriz 'asistencias'
      var asistencias = asignacionDoc.data()?['Asistencia'] ?? {};
      asistencias[idB] = asistencia.toMap();
      await asignacionRef.update({
        'Asistencia': asistencias,
      });
    }
    return 1; // se realizó la inserción exitosamente
  } catch (e) {
    print('Error al agregar asistencia: $e');
    return -1; // ocurrió un error al insertar
  }
}
/***
/*** Actualizar vahiculos ***/

Future<int> updateBitacora(String uid, Bitacora bitacora) async {
  try {
    await db
        .collection("vehiculo")
        .doc(uid)
        .update({'Bitacora.${bitacora.idbitacora}': bitacora.toMap()});
    return 1;
  } catch (e) {
    print('Error al agregar vehículo: $e');
    return -1; // ocurrió un error al insertar
  }
}

int? obtenerNumeroMes(String nombreMes) {
  final meses = {
    'enero': 1,
    'febrero': 2,
    'marzo': 3,
    'abril': 4,
    'mayo': 5,
    'junio': 6,
    'julio': 7,
    'agosto': 8,
    'septiembre': 9,
    'octubre': 10,
    'noviembre': 11,
    'diciembre': 12,
  };

  final nombreMesLowerCase = nombreMes.toLowerCase();
  if (meses.containsKey(nombreMesLowerCase)) {
    return meses[nombreMesLowerCase];
  }

  return null; // Mes inválido
}
*/