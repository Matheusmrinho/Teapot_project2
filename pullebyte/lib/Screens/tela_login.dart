import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';
import 'package:pullebyte/CustomWidgets/main_text.dart';
import 'package:pullebyte/theme/colors.dart';

class TelaLogin extends StatelessWidget {
  final String assetName = 'lib/Assets/Soccer-cuate.svg';

  const TelaLogin({super.key}); // Adiciona um parâmetro de chave ao construtor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 110,
        centerTitle: true,
        leadingWidth: 300,
        leading: Container(
          padding: const EdgeInsets.only(left: 16),
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: LogoHeader(),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: SvgPicture.asset(
                  assetName,
                  fit: BoxFit.contain,
                  semanticsLabel: 'Soccer Image',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const TextFieldSample(hintText: "Email", isSenha: false),
                      const SizedBox(height: 16),
                      const TextFieldSample(hintText: "Senha", isSenha: true),
                      const SizedBox(height: 24),
                      MainButton(
                        text: "Login",
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      ),
                      const SizedBox(height: 20),

                      const LinkAndText(
                        text: "Ainda não possui login? ",
                        linkText: "Cadastre-se",
                        route: '/tela_cadastro',
                        alignment: MainAxisAlignment.end,
                      ),
                      const SizedBox(height: 30),
                      const LinkAndText(
                        text: "",
                        route: '/tela_cadastro',
                        linkText: "Esqueceu a senha?",
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
