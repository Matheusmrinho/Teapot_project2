// tela_cadastro.dart

import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';  

class TelaCadastro extends StatelessWidget {
  final String assetName = 'lib/Assets/Icon_cadastro.svg';

  TelaCadastro({Key? key}) : super(key: key); // Adiciona um parâmetro de chave ao construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorScheme.background,
      appBar: AppBar(
        backgroundColor: customColorScheme.primary,
        title: const Text('Cadastro'), // Usa um construtor const
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Usa um construtor const
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
  children: <Widget>[
    Expanded(
      child: SvgPicture.asset(
        assetName,
        fit: BoxFit.contain, // Usa BoxFit.contain para manter a proporção da imagem
        semanticsLabel: 'Logo',
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            style: TextStyle(color: customColorScheme.background),
            textAlign: TextAlign.center,
            decoration:  InputDecoration(
              fillColor: customColorScheme.onPrimary,
              filled: true,
              labelText: 'Nome de Usuário',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  style: TextStyle(color: customColorScheme.background),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: customColorScheme.onPrimary,
                    filled: true,
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  style: TextStyle(color: customColorScheme.background),
                  textAlign: TextAlign.center,
                  obscureText: true, // Para esconder a senha
                  decoration: InputDecoration(
                    fillColor: customColorScheme.onPrimary,
                    filled: true,
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}