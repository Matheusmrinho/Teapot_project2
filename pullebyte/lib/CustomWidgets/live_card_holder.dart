import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/live_card.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';

class CardHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60.0, right: 35, left: 35),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ao vivo"),
                    SizedBox(width: 8), // Adicionando um espaço entre os textos
                    Text("Liga"),
                  ],
                ),
                const SizedBox(height: 8), // Adicionando um espaço entre a linha de texto e os cards
                Row(
                  children: List.generate(
                    50,
                    (index) => const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: LiveCard(),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
