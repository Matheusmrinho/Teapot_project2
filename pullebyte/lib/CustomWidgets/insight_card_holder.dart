import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/insghts_card.dart';

class InsightCardHolder extends StatelessWidget {
  final bool isLoading;

  const InsightCardHolder({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> insightsData = [
      {
        'titulo': 'Pulles\nbatidas',
        'conteudo': '47/78',
      },
      {
        'titulo': 'Lucro\nacumuado',
        'conteudo': '234.2 R\$',
      },
      {
        'titulo': 'Cotação\nmédia',
        'conteudo': '2.14',
      },
      {
        'titulo': 'Perdas\nacumuladas',
        'conteudo': '27.5 R\$',
      },
      {
        'titulo': 'Maior cotação\nganha',
        'conteudo': '2.47',
      },
    ];

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Estatisticas dos\ncanhotos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 2),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 220,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: insightsData.map((data) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InsghtsCard(
                                titulo: data['titulo']!,
                                conteudo: data['conteudo']!,
                              ),
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
