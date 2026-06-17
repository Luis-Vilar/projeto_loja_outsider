// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  factory CamisaModel.fromStringResponse(String response) {
    final Map<String, dynamic> jsonMap = json.decode(response);

    final double precoBaseResponse = jsonMap['precoBase'] as double;
    final List<Map<String, String>> modelosResponse =
        List<Map<String, String>>.from(['modelos']);
    final List<String> tamanhosDisponiblesResponse = List<String>.from(
      jsonMap['tamanhosDisponibles'],
    );

    return CamisaModel(
      precoBase: precoBaseResponse,
      modelos: modelosResponse,
      tamanhosDisponibles: tamanhosDisponiblesResponse,
    );
  }
}
