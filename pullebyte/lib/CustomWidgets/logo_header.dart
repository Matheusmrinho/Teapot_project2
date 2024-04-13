import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoHeader extends StatelessWidget {
  final String pulleLogo = 'lib/Assets/pulle-logo.svg'; // Movido para dentro do corpo da classe
  const LogoHeader({super.key}); // Correção no construtor

  @override
  Widget build(BuildContext context) {
    return 
    SvgPicture.asset(
      pulleLogo,
      fit: BoxFit.contain, // Usa BoxFit.contain para manter a proporção da imagem
      semanticsLabel: 'Logo',
    );
  }
}
