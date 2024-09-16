import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/matchs_calendar.dart';
import 'dart:convert';

import 'package:pullebyte/color_scheme_controller.dart';

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
    final colorScheme = Provider.of<ColorSchemeController>(context).customColorScheme;
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
            Center(
              child: Text(
                "Não há jogos previstos no momento",
                style: TextStyle(
                  color: colorScheme.primary, // Define a cor do texto como vermelho
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
