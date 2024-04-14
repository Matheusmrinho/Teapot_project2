// tela_cadastro.dart

import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';

class TelaCadastro extends StatelessWidget {
  final String assetName = 'lib/Assets/Icon_cadastro.svg';

  const TelaCadastro({super.key}); // Adiciona um parâmetro de chave ao construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorScheme.background,
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 110,
        leadingWidth: 300,
        leading: Container(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left_sharp), // Usa um construtor const
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 2),
                child: LogoHeader(),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: SvgPicture.asset(
                  assetName,
                  fit: BoxFit.contain, // Usa BoxFit.contain para manter a proporção da imagem
                  semanticsLabel: 'Logo',
                  height: 500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const TextFieldSample(hintText: 'Nome de Usuário', isSenha: false,),
                    const SizedBox(height: 16),
                    const TextFieldSample(hintText: "Email", isSenha: false),
                    const SizedBox(height: 16),
                    const TextFieldSample(hintText: "Senha", isSenha: true),
                    const SizedBox(height: 24),
                    MainButton(text: "Cadastrar",onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },),
                    const SizedBox(height: 24),                     
                  ],
                ),
              ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
