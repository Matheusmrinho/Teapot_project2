import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/filtro_time_holder.dart';
import 'package:pullebyte/CustomWidgets/custom_app_bar.dart';
import 'package:pullebyte/CustomWidgets/live_card_holder.dart';
import 'package:pullebyte/CustomWidgets/match_card_holder.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              FiltroTime(),
              CardHolder(),
              CalendarGameMatch(),
            ],
          ),
        ),
      ),
    );
  }
}
