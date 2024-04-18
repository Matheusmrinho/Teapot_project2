import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/Filtro.dart';
import 'package:pullebyte/CustomWidgets/custom_app_bar.dart';
import 'package:pullebyte/CustomWidgets/live_card_holder.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';

class Canhotos extends StatelessWidget {
  const Canhotos({super.key});

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
                    Navigator.pushNamed(context, '/tela_login');
                  },
                  child: const Text('Login'),
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
