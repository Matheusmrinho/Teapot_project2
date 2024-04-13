import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';
import 'Screens/tela_cadastro.dart';
import 'Screens/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Pullebyte',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: customColorScheme,
      useMaterial3: true,
    ),
    initialRoute: '/tela_cadastro',
    routes: {
      '/tela_cadastro': (context) => const TelaCadastro(),
      '/home': (context) => const Home(),
    },
  ));
}
