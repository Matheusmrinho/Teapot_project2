import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/custom_app_bar.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calcula a posição horizontal desejada em porcentagem da tela (ex: 10%)
    final leftPosition = screenWidth * 0.05;

    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/tela_cadastro');
                  },
                  child: const Text('Insights'),
                ),
                const SizedBox(height: 16),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}