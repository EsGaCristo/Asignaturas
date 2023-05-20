class Asignacion {
  String salon;
  String edificio;
  String horario;
  String docente;
  String materia;

  Asignacion(
      {required this.salon,
      required this.edificio,
      required this.horario,
      required this.docente,
      required this.materia});

  Map<String,dynamic> toMap(){
    return{
      'salon': salon,
      'edificio': edificio,
      'horario': horario,
      'docente':docente,
      'materia': materia
    };
  }
}
