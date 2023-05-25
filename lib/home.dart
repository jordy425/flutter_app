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
        child: Column(
          children: [
            SizedBox(height: 25),
            Image.network('https://img.freepik.com/foto-gratis/tienda-ropa-tienda-ropa-perchas-tienda-boutique-moderna_1150-8886.jpg', height: 200,),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductosP()),
                );
              },
              child: const Text('Ir a comprar'),
            ),
          ],
        )
      ),
    );
  }
}
