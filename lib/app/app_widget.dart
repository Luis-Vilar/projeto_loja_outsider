import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:projeto_camiseta_outisder/app/data/camisa_repository.dart';
import 'package:projeto_camiseta_outisder/app/data/compra_model.dart';
import 'package:projeto_camiseta_outisder/app/utils/extensions.dart';
import 'package:projeto_camiseta_outisder/app/view/components/button_compra.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final camisa = CamisaRepository().camisaModel;
  late String _assetModeloSeleccionado = camisa.modelos[0]['imagePath'];
  late String _modeloSeleccionado = camisa.modelos[0]['cor'].toString();
  late String _tamanhoSelecionado = camisa.tamanhosDisponibles[0];
  int _quantidadeSelecionada = 1;
  bool _embalarPresente = false;
  double _parcelasSelecionada = 1;
  double totalCompra = 0;
  Widget get selectorModelo => RadioGroup<String>(
    groupValue: _assetModeloSeleccionado,
    onChanged: (value) => setState(() {
      _assetModeloSeleccionado = value!;
    }),
    child: Column(
      children: camisa.modelos
          .map(
            (modelo) => RadioListTile<String>(
              title: Text(
                '${modelo['cor']}'.toCapitalized(),
                style: TextStyle(fontSize: 12, fontWeight: .w400),
              ),
              value: modelo['imagePath'],
              onChanged: (value) => {
                setState(() {
                  _modeloSeleccionado = modelo['cor'];
                }),
              },
            ),
          )
          .toList(),
    ),
  );

  Widget get selectorTamanho => DropdownButton<String>(
    value: _tamanhoSelecionado,
    icon: const Icon(Icons.arrow_drop_down),
    underline: const SizedBox(), // Remove a linha preta padrão de baixo
    style: const TextStyle(
      color: Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    onChanged: (value) {
      setState(() {
        _tamanhoSelecionado = value!;
      });
    },
    // Mapeia a lista de strings para os itens visíveis do menu
    items: camisa.tamanhosDisponibles.map((String valor) {
      return DropdownMenuItem<String>(value: valor, child: Text(valor));
    }).toList(),
  );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double safeWidth = (screenWidth / 2) * 0.95;
    totalCompra = camisa.precoBase;

    CompraModel compra = CompraModel.factory(
      camisa,
      _quantidadeSelecionada,
      _embalarPresente,
      _parcelasSelecionada.toInt(),
      _modeloSeleccionado,
      _tamanhoSelecionado,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Loja Outsider',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: safeWidth,
                  child: Column(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        'Seleccione a cor',
                        style: TextStyle(fontWeight: .w600),
                      ),
                      selectorModelo,
                    ],
                  ),
                ),
                SizedBox(
                  width: safeWidth,
                  child: Image.asset(_assetModeloSeleccionado),
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Tamanho : ", style: TextStyle(fontWeight: .w600)),
                  selectorTamanho,
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Quantidade : ", style: TextStyle(fontWeight: .w600)),
                  Row(
                    children: [
                      Ink(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 1.5),
                          color: Colors
                              .transparent, // Cambia si quieres fondo con color
                        ),
                        child: InkWell(
                          child: Icon(Icons.remove, color: Colors.red),
                          onTap: () => setState(() {
                            if (_quantidadeSelecionada > 1) {
                              _quantidadeSelecionada--;
                            }
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _quantidadeSelecionada.toString(),
                          style: TextStyle(fontWeight: .w600),
                        ),
                      ),
                      Ink(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 1.5),
                          color: Colors
                              .transparent, // Cambia si quieres fondo con color
                        ),
                        child: InkWell(
                          child: Icon(Icons.add, color: Colors.green),
                          onTap: () => setState(() {
                            _quantidadeSelecionada++;
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'Embalar para presente ? (+ R\$ ${camisa.valorPresente})',
                    style: TextStyle(fontSize: 10),
                  ),
                  Checkbox(
                    value: _embalarPresente,
                    onChanged: (bool? value) {
                      setState(() {
                        _embalarPresente = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .start,
                    children: [
                      Text(
                        'Parcelas : ${_parcelasSelecionada.toInt()} x',
                        style: TextStyle(fontWeight: .w500, fontSize: 12),
                      ),
                    ],
                  ),
                  Slider(
                    min: 1,
                    max: camisa.maxParcelas.toDouble(),
                    divisions: camisa.maxParcelas - 1,
                    value: _parcelasSelecionada,
                    onChanged: (double newValue) => setState(() {
                      _parcelasSelecionada = newValue;
                    }),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: .min,
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                SizedBox(
                  width: screenWidth * 0.9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      border: .all(color: Colors.lightBlue),
                      borderRadius: .circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total: ${compra.precoFinal.toBRL()}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 4.0,
                        ), // Pequeño espacio entre ambos textos
                        // Texto del Detalle de Cuotas
                        Text(
                          '(${_parcelasSelecionada.toInt()} x de ${(compra.precoFinal / _parcelasSelecionada).toDouble().toBRL()})',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                ButtonCompraWidget(screenWidth: screenWidth, compra: compra),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void bootstrap() => runZonedGuarded(
  () {
    runApp(const MyApp());
  },
  (error, stackTrace) {
    log('Uncontrolled Error : ', error: error, stackTrace: stackTrace);
    debugger(message: error.toString());
  },
);
