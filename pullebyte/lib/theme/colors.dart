import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/color_scheme_controller.dart';

class CustomColors {
  static const Color primaryColor = Color(0xffff6c27);
  static const Color sec = Color.fromARGB(255, 255, 146, 95);
  static const Color accentColor = Color(0xff262626);
  static const Color backgroundColor = Color(0xff0f1821);
  static const Color darkergrey = Color(0xff262626);
  static const Color textColor = Color(0xfffaf5ea);
  static const Color textFieldColor = Color(0xfffaf5ea);
  static const Color buttonColor = Color(0xffff6c27);

  // Cores para daltonismo
  static const Color primaryColorDaltonism = Color(0xff00aaff);
  static const Color secDaltonism = Color(0xff00ffaa);
  static const Color accentColorDaltonism = Color(0xffaa00ff);
  static const Color backgroundColorDaltonism = Color(0xff0f1821);
  static const Color darkergreyDaltonism = Color(0xff262626);
  static const Color textColorDaltonism = Color(0xfffaf5ea);
  static const Color textFieldColorDaltonism = Color(0xfffaf5ea);
  static const Color buttonColorDaltonism = Color(0xff00aaff);
}

// Função para obter o esquema de cores, baseada no valor de isDisable
var customColorScheme = (BuildContext context) {
  // Obtém o valor de isDisable do Provider
  final isDisable = context.watch<ColorSchemeController>().isDisable;

  // Define e retorna o esquema de cores com base no estado de isDisable
  return ColorScheme(
  background: isDisable ? CustomColors.backgroundColorDaltonism : CustomColors.backgroundColor,
  onBackground: isDisable ? CustomColors.backgroundColorDaltonism : CustomColors.backgroundColor,
  primary: isDisable ? CustomColors.primaryColorDaltonism : CustomColors.primaryColor,
  secondary: isDisable ? CustomColors.accentColorDaltonism : CustomColors.accentColor,
  surface: isDisable ? CustomColors.backgroundColorDaltonism : CustomColors.backgroundColor,
  error: isDisable ? CustomColors.accentColorDaltonism : Colors.red,
  onPrimary: isDisable ? CustomColors.textColorDaltonism : CustomColors.textColor,
  onSecondary: isDisable ? CustomColors.textColorDaltonism : CustomColors.textColor,
  onSurface: isDisable ? CustomColors.textColorDaltonism : CustomColors.textColor,
  onError: Colors.white,
  brightness: Brightness.dark,
);

};