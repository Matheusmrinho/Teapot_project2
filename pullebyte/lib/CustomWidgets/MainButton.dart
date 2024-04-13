import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

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
        height: 45,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: customColorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: customColorScheme.onPrimary,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
