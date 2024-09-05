import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  CadastroScreen({super.key});

  void _register(BuildContext context) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem.'),
        ),
      );
      return;
    }

    await _databaseController
        .registerWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
      _usernameController.text,
    )
        .then((user) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso.'),
        ),
      );
    }).catchError((e) {
      String errorMessage = getErrorMessage(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    });
  }

  String getErrorMessage(dynamic error) {
    print('Erro capturado: $error');
    print('Tipo de erro: ${error.runtimeType}');
    
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'Este email já está em uso.';
        case 'invalid-email':
          return 'Email inválido.';
        case 'weak-password':
          return 'A senha é muito fraca.';
        default:
          return 'Ocorreu um erro ao efetuar o cadastro. Por favor, verifique se os dados foram inseridos corretamente.';
      }
    } else if (error is Exception && error.toString().contains('firebase_auth')) {
      String errorCode = error.toString().split('[')[1].split(']')[0];
      switch (errorCode) {
        case 'firebase_auth/email-already-in-use':
          return 'Este email já está em uso.';
        case 'firebase_auth/invalid-email':
          return 'Email inválido.';
        case 'firebase_auth/weak-password':
          return 'A senha é muito fraca.';
        default:
          return 'Ocorreu um erro ao efetuar o cadastro. Por favor, verifique se os dados foram inseridos corretamente.';
      }
    } else {
      return 'Ocorreu um erro. Por favor, tente novamente.';
    }
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
                icon: const Icon(FeatherIcons.chevronLeft),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              assetName,
              fit: BoxFit.contain,
              semanticsLabel: 'Logo',
              height: 300,
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
                    const SizedBox(height: 16),
                    TextFieldSample(
                      controller: _confirmPasswordController,
                      hintText: 'Confirmar Senha',
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
            ),
          ],
        ),
      ),
    );
  }
}
