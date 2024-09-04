import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:pullebyte/controller_Database.dart';
import 'package:pullebyte/Screens/tela_login.dart'; // Importe a tela de login

class PasswordRecoveryScreen extends StatefulWidget {
  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final TextEditingController _emailController = TextEditingController();
  final DatabaseController _databaseController = DatabaseController();
  String? _resetMessage;

  void _sendPasswordReset() async {
    final email = _emailController.text;
    if (email.isNotEmpty) {
      try {
        await _databaseController.resetPasswordWithEmail(email);
        setState(() {
          _resetMessage = 'Um link para redefinição de senha foi enviado para o e-mail $email, caso o mesmo esteja cadastrado.';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao enviar e-mail de redefinição de senha.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um e-mail válido.'),
        ),
      );
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    const String assetName = 'lib/Assets/Security.svg'; 
    return Scaffold(
      backgroundColor: customColorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 110,
        centerTitle: true,
        leadingWidth: 300,
        leading: Container(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: _navigateToLogin,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: LogoHeader(),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 3.0), // Menos padding no topo
              child: SvgPicture.asset(
                assetName,
                fit: BoxFit.contain,
                height: 250, // Ajuste a altura se necessário
                semanticsLabel: 'Recuperação de Senha',
              ),
            ),
            const SizedBox(height: 16), // Menos espaço entre imagem e texto
            const Text(
              'Digite seu email cadastrado na plataforma para a redefinição da senha',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16), // Menos espaço entre texto e campo de entrada
            TextFieldSample(
              controller: _emailController,
              hintText: "Email",
              isSenha: false,
            ),
            const SizedBox(height: 16), // Menos espaço entre campo de entrada e botão
            MainButton(
              text: "Recuperar",
              onPressed: _sendPasswordReset,
            ),
            const SizedBox(height: 12), // Menos espaço entre botão e mensagem
            if (_resetMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0), // Menos padding na mensagem
                child: Text(
                  _resetMessage!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
