import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';
import 'package:pullebyte/CustomWidgets/main_text.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:pullebyte/controller_database.dart';

class LoginScreen extends StatelessWidget {
  final DatabaseController _databaseController = DatabaseController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _login(BuildContext context) async {
    await _databaseController
        .signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    )
        .then((user) async {
      Navigator.popAndPushNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso.'),
        ),
      );
      await _databaseController.addUserInfo();
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
    // Adiciona um log para verificar o tipo de erro
    print('Erro capturado: $error');
    print('Tipo de erro: ${error.runtimeType}');
    
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'Usuário não encontrado.';
        case 'wrong-password':
          return 'Senha incorreta.';
        case 'invalid-email':
          return 'Email inválido.';
        default:
          return 'Ocorreu um erro ao efetuar o login. Por favor, verifique se o email e senha foram inseridos corretamente.';
      }
    } else if (error is Exception && error.toString().contains('firebase_auth')) {
      // Extrai o código de erro da mensagem da exceção
      String errorCode = error.toString().split('[')[1].split(']')[0];
      switch (errorCode) {
        case 'firebase_auth/user-not-found':
          return 'Usuário não encontrado.';
        case 'firebase_auth/wrong-password':
          return 'Email ou Senha incorretas.';
        case 'firebase_auth/invalid-email':
          return 'Email inválido, tente usar um endereço de email válido.';
        default:
          return 'Ocorreu um erro ao efetuar o login. Por favor, verifique se o email e senha foram inseridos corretamente.';
      }
    } else {
      return 'Ocorreu um erro. Por favor, tente novamente.';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String assetName = 'lib/Assets/Soccer-cuate.svg';
    return Scaffold(
      backgroundColor: customColorScheme.surface,
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
                  fit: BoxFit.cover,
                  semanticsLabel: 'Soccer Image',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      TextFieldSample(
                        controller: _emailController,
                        hintText: "Email",
                        isSenha: false,
                      ),
                      const SizedBox(height: 16),
                      TextFieldSample(
                        controller: _passwordController,
                        hintText: "Senha",
                        isSenha: true,
                      ),
                      const SizedBox(height: 24),
                      MainButton(text: "Login", onPressed: () => _login(context)),
                      const SizedBox(height: 20),
                      const LinkAndText(
                        text: "Ainda não possui login? ",
                        linkText: "Cadastre-se",
                        route: '/tela_cadastro',
                        alignment: MainAxisAlignment.end,
                      ),
                      const SizedBox(height: 20),
                      const LinkAndText(
                        text: "",
                        route: '/tela_recuperar_senha',
                        linkText: "Esqueceu a senha?",
                      ),
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
