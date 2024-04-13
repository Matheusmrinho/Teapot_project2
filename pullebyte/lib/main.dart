import 'package:flutter/material.dart';
import 'Screens/tela_cadastro.dart';
import 'Screens/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/tela_cadastro',
    routes: {
      '/tela_cadastro': (context) => TelaCadastro(),
      '/home': (context) => Home(),
    },
  ));
}
