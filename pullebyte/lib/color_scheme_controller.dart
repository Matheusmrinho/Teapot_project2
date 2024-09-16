import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorSchemeController extends ChangeNotifier {
  bool _isDisable = false;

  bool get isDisable => _isDisable;

  void toggleColorScheme() {
    _isDisable = !_isDisable;
    notifyListeners();
  }
  void setColorScheme(bool isDisable) {
    _isDisable = isDisable;
    notifyListeners();
  } 
  

  ColorScheme get customColorScheme {
    return ColorScheme(
      background: _isDisable ? CustomColors.backgroundColor : CustomColors.backgroundColorDaltonism,
      onBackground: _isDisable ? CustomColors.backgroundColor : CustomColors.backgroundColorDaltonism,
      primary: _isDisable ? CustomColors.primaryColor : CustomColors.primaryColorDaltonism,
      secondary: _isDisable ? CustomColors.accentColor : CustomColors.accentColorDaltonism,
      surface: _isDisable ? CustomColors.backgroundColor : CustomColors.backgroundColorDaltonism,
      error: _isDisable ? Colors.red : CustomColors.accentColorDaltonism,
      onPrimary: _isDisable ? CustomColors.textColor : CustomColors.textColorDaltonism,
      onSecondary: _isDisable ? CustomColors.textColor : CustomColors.textColorDaltonism,
      onSurface: _isDisable ? CustomColors.textColor : CustomColors.textColorDaltonism,
      onError: Colors.white,
      brightness: Brightness.dark,
    );
  }
}

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
