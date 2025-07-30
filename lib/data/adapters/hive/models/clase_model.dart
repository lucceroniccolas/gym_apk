import 'package:hive/hive.dart';
import 'package:gym_apk/domain/entities/clases.dart';

part 'clase_model.g.dart';

@HiveType(typeId: 1)
class ClaseHive extends HiveObject {
  @HiveField(0)
  int idClase;

  @HiveField(1)
  String nombreClase;

  @HiveField(2)
  String? descripcion;

  @HiveField(3)
  int cupos;

  @HiveField(4)
  DateTime? horario;

  ClaseHive({
    required this.idClase,
    required this.nombreClase,
    this.descripcion,
    required this.cupos,
    this.horario,
  });

  // Convierte una entidad de dominio a un modelo de Hive
  factory ClaseHive.fromEntity(Clase clase) {
    return ClaseHive(
      idClase: clase.idClase,
      nombreClase: clase.nombreClase,
      descripcion: clase.descripcion ?? clase.descripcion,
      cupos: clase.cupos,
      horario: clase.horario ?? clase.horario,
    );
  }
  //Convierte un modelo de Hive a una entidad de dominio
  Clase toEntity() {
    return Clase(
      idClase: idClase,
      nombreClase: nombreClase,
      descripcion: descripcion,
      cupos: cupos,
      horario: horario,
    );
  }
}
