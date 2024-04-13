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
    return Theme(
      data: ThemeData(
        colorScheme: customColorScheme, 
      ),
      child: SizedBox(
        width: 250,
        child: TextField(
          obscureText: is_senha,
          style: TextStyle(color: CustomColors.textColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: CustomColors.backgroundColor,
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