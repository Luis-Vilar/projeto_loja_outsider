// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:projeto_camiseta_outisder/app/data/camisa_model.dart';

abstract class Compra {
  Camisa camisa;
  String tamanho;
  String modelo;
  int quantidade;
  bool presente;
  int parcelas;
  double precoFinal = 0;
  Compra({
    required this.camisa,
    required this.tamanho,
    required this.modelo,
    required this.quantidade,
    required this.presente,
    required this.parcelas,
  });
}

final class CompraModel extends Compra {
  CompraModel({
    required super.camisa,
    required super.quantidade,
    required super.presente,
    required super.parcelas,
    required super.tamanho,
    required super.modelo,
  });

  factory CompraModel.factory(
    Camisa camisa,
    int quantidade,
    bool presente,
    int parcelas,
    String modelo,
    String tamanho,
  ) {
    double precoFinal = 0;

    if (parcelas == 0) {
      if (!presente) {
        precoFinal = camisa.precoBase * quantidade;
      } else {
        precoFinal = (camisa.precoBase * quantidade) + camisa.valorPresente;
      }
    } else {
      if (!presente) {
        precoFinal =
            (camisa.precoBase * quantidade) *
            (1 + (parcelas * camisa.jurosPorParcela));
      } else {
        precoFinal =
            ((camisa.precoBase * quantidade) *
                (1 + (parcelas * camisa.jurosPorParcela))) +
            camisa.valorPresente;
      }
    }

    final compra = CompraModel(
      camisa: camisa,
      quantidade: quantidade,
      presente: presente,
      parcelas: parcelas,
      tamanho: tamanho,
      modelo: modelo,
    );
    compra.precoFinal = precoFinal;

    return compra;
  }

  void printCompra() => print("""
==============================
            Compra
==============================
Modelo      : $modelo
Tamanho     : $tamanho
Quantidade  : $quantidade
Parcelas    : ${parcelas >= 1 ? parcelas : 'não'}
Presente    : ${presente ? 'sim' : 'não'}
Preco Final : $precoFinal

""");
}
