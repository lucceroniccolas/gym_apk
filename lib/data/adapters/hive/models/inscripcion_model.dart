import 'package:hive/hive.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';

part 'inscripcion_model.g.dart';

@HiveType(typeId: 2)
class InscripcionHive extends HiveObject {
  @HiveField(0)
  int idInscripcion;

  @HiveField(1)
  int idUsuario;

  @HiveField(2)
  int idClase;

  @HiveField(3)
  DateTime fechaInscripcion;

  InscripcionHive({
    required this.idInscripcion,
    required this.idUsuario,
    required this.fechaInscripcion,
    required this.idClase,
  });

  factory InscripcionHive.fromEntity(Inscripcion inscripcion) {
    return InscripcionHive(
      idInscripcion: inscripcion.idInscripcion,
      idUsuario: inscripcion.idUsuario,
      fechaInscripcion: inscripcion.fechaInscripcion,
      idClase: inscripcion.idClase,
    );
  }
  Inscripcion toEntity() {
    return Inscripcion(
      idInscripcion: idInscripcion,
      idUsuario: idUsuario,
      fechaInscripcion: fechaInscripcion,
      idClase: idClase,
    );
  }
}
