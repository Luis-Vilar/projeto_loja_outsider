import 'package:flutter/material.dart';
import 'package:projeto_camiseta_outisder/app/data/compra_model.dart';

class ButtonCompraWidget extends StatelessWidget {
  const ButtonCompraWidget({
    super.key,
    required this.screenWidth,
    required this.compra,
  });

  final double screenWidth;
  final CompraModel compra;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.9,
          child: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Fundo escuro do botão
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Passamos a usar o "actualContext" gerado pelo Builder
                  compra.printCompra();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Pedido enviado!',
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                      backgroundColor: const Color(
                        0xFF1A1A1A,
                      ), // Cor aproximada da imagem
                      behavior: SnackBarBehavior.fixed,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                child: Text(
                  'Finalizar Compra',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
