import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de Contraseñas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
      ),
      home: PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String generatedPassword = '';
  final TextEditingController lengthController = TextEditingController();
  bool useUppercase = true;
  bool useLowercase = true;
  bool useNumbers = true;
  bool useSpecialChars = true;
  String errorText = '';

  String generatePassword() {
    final String uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final String lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
    final String numberChars = '0123456789';
    final String specialChars = '!@#\$%^&*()_+[]{}|;:,.<>?';

    String allowedChars = '';
    if (useUppercase) allowedChars += uppercaseChars;
    if (useLowercase) allowedChars += lowercaseChars;
    if (useNumbers) allowedChars += numberChars;
    if (useSpecialChars) allowedChars += specialChars;

    if (allowedChars.isEmpty) {
      return 'Selecciona al menos un tipo de carácter.';
    }

    final random = Random();
    String password = '';
    for (int i = 0; i < int.parse(lengthController.text); i++) {
      password += allowedChars[random.nextInt(allowedChars.length)];
    }
    return password;
  }

  void generateButtonPressed() {
    if (lengthController.text.isEmpty) {
      setState(() {
        errorText = 'Por favor, ingresa la longitud de la contraseña.';
      });
    } else {
      setState(() {
        errorText = '';
        generatedPassword = generatePassword();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de Contraseñas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Longitud de la contraseña'),
            ),
            Text(
              errorText,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('Mayúsculas'),
              value: useUppercase,
              onChanged: (value) {
                setState(() {
                  useUppercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Minúsculas'),
              value: useLowercase,
              onChanged: (value) {
                setState(() {
                  useLowercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Números'),
              value: useNumbers,
              onChanged: (value) {
                setState(() {
                  useNumbers = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Caracteres especiales'),
              value: useSpecialChars,
              onChanged: (value) {
                setState(() {
                  useSpecialChars = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateButtonPressed,
              child: Text('Generar Contraseña'),
            ),
            SizedBox(height: 20),
            Text(
              'Contraseña generada:',
              style: TextStyle(
                fontSize: 20, // Tamaño de la fuente
                fontWeight: FontWeight.bold, // Negrita
              ),
            ),
            Text(
              generatedPassword,
              style: TextStyle(
                fontSize: 20, // Tamaño de la fuente
                fontWeight: FontWeight.bold, // Negrita
              ),
            ),
          ],
        ),
      ),
    );
  }
}
