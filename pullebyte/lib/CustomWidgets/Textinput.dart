import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';

class TextFieldSample extends StatelessWidget {
  final String hintText;
  final bool is_senha;

  const TextFieldSample({
    Key? key,
    required this.hintText,
    required this.is_senha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calcula a largura desejada em porcentagem da tela (ex: 70%)
    final width = screenWidth * 0.7;
    return Theme(
      data: ThemeData(
        colorScheme: customColorScheme,
      ),
      child: SizedBox(
        width: width,
        child: TextField(
          obscureText: is_senha,
          style: TextStyle(color: CustomColors.accentColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: CustomColors.textFieldColor,
            border: OutlineInputBorder(),
            hintText: hintText,
            labelText: hintText,
            labelStyle: TextStyle(color: CustomColors.accentColor),
            
          ),
        ),
      ),
    );
  }
}
