import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: const Text('hello word'),
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
