import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model_producto.dart';
import 'db_helper.dart';

class Carrito extends StatelessWidget {
  final List<Product> productos;

  const Carrito({Key? key, required this.productos}) : super(key: key);

  double getValorTotal() {
    double total = 0;
    for (var producto in productos) {
      total += producto.cantidad * producto.precio;
    }
    return total;
  }

  Future<void> _finalizarPedido(BuildContext context) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'productos_database.db'),
      version: 1,
    );

    for (final producto in productos) {
      await database.delete(
        'productos',
        where: 'nombre = ? AND cantidad = ? AND precio = ?',
        whereArgs: [producto.nombre, producto.cantidad, producto.precio],
      );
    }

    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pedido finalizado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Productos Registrados:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return ListTile(
                    title: Text('${producto.nombre} - ${producto.cantidad} - \$${producto.precio}'),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Valor Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${getValorTotal()}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _finalizarPedido(context),
              child: const Text('Finalizar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
