import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/matchs_calendar.dart';
import 'dart:convert';

class CalendarGameMatch extends StatelessWidget {
  final List<dynamic> matchesData;
  final bool isLoading;

  const CalendarGameMatch({
    super.key,
    required this.matchesData,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    bool hasUpcomingMatches = matchesData.any(
      (match) => (match['partidas'] as List<dynamic>).any(
        (partida) => partida['Situacao'] == 'Em breve',
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Próximos Jogos",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (!hasUpcomingMatches)
            const Center(
              child: Text(
                "Não há jogos previstos no momento",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 108, 39), // Define a cor do texto como vermelho
                  fontSize: 16, // Ajusta o tamanho da fonte se necessário
                ),
              ),
            )
          else
            Column(
              children: matchesData.map<Widget>((match) {
                List<dynamic> partidas = match['partidas'];
                return Column(
                  children: partidas.map<Widget>((partida) {
                    return partida['Situacao'] == 'Em breve'
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MatchCalendarCard(
                                jsonData: jsonEncode(partida)),
                          )
                        : const SizedBox.shrink();
                  }).toList(),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
