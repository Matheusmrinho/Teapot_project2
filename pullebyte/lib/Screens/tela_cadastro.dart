import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/controller_database.dart';

class CadastroScreen extends StatelessWidget {
  final DatabaseController _databaseController = DatabaseController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  CadastroScreen({super.key});

  void _register(context) async {
    await _databaseController.registerWithEmailAndPassword(_emailController.text, _passwordController.text, _usernameController.text).then((user) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso.'),
        ),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer cadastro $e'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const String assetName = 'lib/Assets/Icon_cadastro.svg';
    return Scaffold(
      backgroundColor: customColorScheme.surface,
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
                icon: const Icon(FeatherIcons.chevronLeft), // Usa um construtor const
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFieldSample(
                        controller: _usernameController,
                        hintText: 'Nome de Usuário',
                        isSenha: false,
                      ),
                      const SizedBox(height: 16),
                      TextFieldSample(
                        controller: _emailController,
                        hintText: 'Email',
                        isSenha: false,
                      ),
                      const SizedBox(height: 16),
                      TextFieldSample(
                        controller: _passwordController,
                        hintText: 'Senha',
                        isSenha: true,
                      ),
                      const SizedBox(height: 24),
                      MainButton(
                        text: 'Cadastrar',
                        onPressed: () => _register(context),
                      ),
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
