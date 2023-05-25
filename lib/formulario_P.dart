import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'carrito.dart';
import 'model_producto.dart';


class ProductosP extends StatefulWidget {
  const ProductosP({Key? key}) : super(key: key);

  @override
  _ProductosPState createState() => _ProductosPState();
}

class _ProductosPState extends State<ProductosP> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlNombre = TextEditingController();
  final _ctrlCantidad = TextEditingController();
  final _ctrlPrecio = TextEditingController();

  List<Productos> _productos = [];

  void _agregarProducto() {
    if (_formKey.currentState!.validate()) {
      final nombre = _ctrlNombre.text;
      final cantidad = int.parse(_ctrlCantidad.text);
      final precio = double.parse(_ctrlPrecio.text);

      setState(() {
        _productos.add(Productos(nombre: nombre, cantidad: cantidad, precio: precio));
      });

      _ctrlNombre.clear();
      _ctrlCantidad.clear();
      _ctrlPrecio.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ctrlNombre,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ctrlCantidad,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa una cantidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ctrlPrecio,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un precio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _agregarProducto,
                child: const Text('Agregar Producto'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final database = await openDatabase(
                    join(await getDatabasesPath(), 'productos_database.db'),
                    version: 1,
                  );

                  for (final producto in _productos) {
                    await database.insert(
                      'productos',
                      {
                        'nombre': producto.nombre,
                        'cantidad': producto.cantidad,
                        'precio': producto.precio,
                      },
                    );
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Carrito(productos: _productos)),
                  );
                },
                child: const Text('Ver Carrito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
