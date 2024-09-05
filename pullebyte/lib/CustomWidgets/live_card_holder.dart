import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/live_card.dart';
import 'dart:convert';

class CardHolder extends StatelessWidget {
  final List<dynamic> matchesData;
  final bool isLoading;

  const CardHolder(
      {super.key, required this.matchesData, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Ao Vivo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : matchesData.isEmpty
                      ? const Center(
                          child: Text(
                            "Não há jogos ao vivo",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 108, 39), // Define a cor do texto como vermelho
                              fontSize: 16, // Ajusta o tamanho da fonte se necessário
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 140,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: matchesData.map((match) {
                                List<dynamic> partidas = match[
                                    'partidas']; // list<dynamic> partidas = match['campeonato']['partidas'];
                                return Row(
                                  children: partidas.map((partida) {
                                    return partida['Situacao'] != 'Encerrado' &&
                                            partida['Situacao'] !=
                                                'Em breve'
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: LiveCard(
                                                jsonData:
                                                    jsonEncode(partida)),
                                          )
                                        : const SizedBox.shrink();
                                  }).toList(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ],
    );
  }
}
