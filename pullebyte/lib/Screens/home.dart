import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/canhotos_card.dart';
import 'package:pullebyte/CustomWidgets/filtro_time_holder.dart';
import 'package:pullebyte/CustomWidgets/custom_app_bar.dart';
import 'package:pullebyte/CustomWidgets/filtro_time_logic.dart';
import 'package:pullebyte/CustomWidgets/live_card_holder.dart';
import 'package:pullebyte/CustomWidgets/match_card_holder.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List<dynamic> matchesData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FiltroTimeLogic>(context, listen: false).fetchMatchData();
    });
    _fetchMatchData();
  }

 Future<void> _fetchMatchData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FiltroTimeLogic>(context, listen: false).fetchMatchData();
    });
      setState(() {
        isLoading = false;
      });
    }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    await _fetchMatchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(),
                const FiltroTime(),
                CardHolder(
                  matchesData: context.watch<FiltroTimeLogic>().timesSelecionadosFiltrados,
                  isLoading: isLoading,
                ),
                CalendarGameMatch(
                  matchesData: context.watch<FiltroTimeLogic>().timesSelecionadosFiltrados,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}