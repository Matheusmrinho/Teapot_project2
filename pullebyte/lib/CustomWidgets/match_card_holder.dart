import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/live_card.dart';
import 'package:pullebyte/CustomWidgets/matchs_calendar.dart';

class CalendarGameMatch extends StatelessWidget {
  const CalendarGameMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              const Text("Jogos futuros", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              Column(
                children: List.generate(
                  10,
                  (index) => const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: MatchCalendarCard(),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
