import 'package:flutter/material.dart';

import 'formulario_P.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STREET VICES'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductosP()),
            );
          },
          child: const Text('Ir a comprar'),
        ),
      ),
    );
  }
}
