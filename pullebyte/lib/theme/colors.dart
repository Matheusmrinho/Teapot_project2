import 'package:flutter/material.dart';

class CustomColors {
  // Defina cores personalizadas como constantes estáticas
  static const Color primaryColor = Color(0xffff6c27);
  static const Color sec = Color.fromARGB(255, 255, 146, 95);
  static const Color accentColor = Color(0xff262626);
  static const Color backgroundColor = Color(0xff0f1821);
  static const Color darkergrey = Color(0xff262626);
  static const Color textColor = Color(0xfffaf5ea);
  static const Color textFieldColor = Color(0xfffaf5ea);
  static const Color buttonColor = Color(0xffff6c27);

}

const customColorScheme = ColorScheme(
  background: CustomColors.backgroundColor,
  onBackground: CustomColors.backgroundColor,
  primary: CustomColors.primaryColor,
  secondary: CustomColors.accentColor,
  surface: CustomColors.backgroundColor,
  error: Colors.red, // Se desejar uma cor de erro personalizada
  onPrimary: CustomColors.textColor,
  onSecondary: CustomColors.textColor,
  onSurface: CustomColors.textColor,
  onError: Colors.white,
  brightness: Brightness.dark, // Ou ajuste para Brightness.dark conforme necessário
);