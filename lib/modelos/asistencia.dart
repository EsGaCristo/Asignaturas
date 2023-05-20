class Asistencia{
  String fecha;
  String revisor;
  String idasistencia;

  Asistencia({required this.idasistencia, required this.fecha, required this.revisor});

  Map<String,dynamic> toMap(){
    return{
      'idasistencia':idasistencia,
      'fecha':fecha,
      'revisor':revisor
    };
  }

}