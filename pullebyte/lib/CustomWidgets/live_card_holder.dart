import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/live_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CardHolder extends StatefulWidget {
  const CardHolder({super.key});
  @override
  _CardHolderState createState() => _CardHolderState();
}

class _CardHolderState extends State<CardHolder> {
  var matchesData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMatchData();
  }

  Future<void> _fetchMatchData() async {
    const url = 'https://pullebyte.onrender.com/matches-data';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);

      setState(() {
        matchesData = decodedData['campeonatos'];
        isLoading = false;
      });
    }
  }

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
                  : SizedBox(
                      height: 140,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: matchesData.map((match) {
                            List<dynamic> partidas = match['partidas'];
                            return Row(
                              children: partidas.map((partida) {
                                return partida['Situacao'] != 'Encerrado' && partida['Situacao'] != 'Em breve'
                                    ? Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: LiveCard(jsonData: jsonEncode(partida)),
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
