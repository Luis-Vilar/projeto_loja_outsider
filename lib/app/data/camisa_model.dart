// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Camisa {
  double precoBase;
  List<String> tamanhosDisponibles;
  List<Map<String, String>> modelos;
  Camisa({
    required this.precoBase,
    required this.tamanhosDisponibles,
    required this.modelos,
  });
}

final class CamisaModel extends Camisa {
  CamisaModel({
    required super.precoBase,
    required super.tamanhosDisponibles,
    required super.modelos,
  });
}
