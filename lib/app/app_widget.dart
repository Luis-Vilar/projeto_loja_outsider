import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:projeto_camiseta_outisder/app/data/camisa_repository.dart';
import 'package:projeto_camiseta_outisder/app/utils/extensions.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final camisa = CamisaRepository().camisaModel;
  late String _modeloSeleccionado = camisa.modelos[0]['imagePath'];
  late String _tamanhoSelecionado = camisa.tamanhosDisponibles[0];
  int _quantidadeSelecionada = 0;

  Widget get selectorModelo => RadioGroup<String>(
    groupValue: _modeloSeleccionado,
    onChanged: (value) => setState(() {
      _modeloSeleccionado = value!;
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
                  child: Image.asset(_modeloSeleccionado),
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
                            if (_quantidadeSelecionada >= 1) {
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
