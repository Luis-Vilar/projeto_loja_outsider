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
