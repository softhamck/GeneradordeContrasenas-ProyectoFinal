import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Notas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
      ),
      home: const MyHomePage(title: 'Calculadora de Notas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();
  final TextEditingController nota4Controller = TextEditingController();
  double promedio = 0.0;
  String errorText = '';
  String resultado = '';

  void _calcularPromedio() {
    final nota1 = double.tryParse(nota1Controller.text) ?? 0.0;
    final nota2 = double.tryParse(nota2Controller.text) ?? 0.0;
    final nota3 = double.tryParse(nota3Controller.text) ?? 0.0;
    final nota4 = double.tryParse(nota4Controller.text) ?? 0.0;

    if (nota1 >= 0 && nota2 >= 0 && nota3 >= 0 && nota4 >= 0) {
      final total = nota1 + nota2 + nota3 + nota4;
      final promedio = total / 4;

      setState(() {
        this.promedio = promedio;
        errorText = '';
        resultado = (promedio >= 3.0) ? 'Ganó la materia' : 'Perdió la materia';
      });
    } else {
      setState(() {
        errorText = 'Las notas deben ser números no negativos.';
        promedio = 0.0;
        resultado = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nota1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nota 1',
                errorText: nota1Controller.text.isNotEmpty && double.tryParse(nota1Controller.text) == null
                    ? 'Ingrese un número válido'
                    : null,
              ),
            ),
            TextField(
              controller: nota2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nota 2',
                errorText: nota2Controller.text.isNotEmpty && double.tryParse(nota2Controller.text) == null
                    ? 'Ingrese un número válido'
                    : null,
              ),
            ),
            TextField(
              controller: nota3Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nota 3',
                errorText: nota3Controller.text.isNotEmpty && double.tryParse(nota3Controller.text) == null
                    ? 'Ingrese un número válido'
                    : null,
              ),
            ),
            TextField(
              controller: nota4Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nota 4',
                errorText: nota4Controller.text.isNotEmpty && double.tryParse(nota4Controller.text) == null
                    ? 'Ingrese un número válido'
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularPromedio,
              child: Text('Calcular Promedio'),
            ),
            const SizedBox(height: 20),
            Text(
              'Promedio: $promedio',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: promedio >= 3.0 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 8), // Agregamos espacio entre el promedio y el mensaje
            Text(
              resultado,
              style: TextStyle(
                fontSize: 20,
                color: promedio >= 3.0 ? Colors.green : Colors.red,
              ),
            ),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
