import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/custom_app_bar.dart';
import 'package:pullebyte/CustomWidgets/insight_card_holder.dart';
import 'package:pullebyte/CustomWidgets/grafico_insight.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              const InsightCardHolder(isLoading: false),
              // const Insightgrafico(isLoading: false),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
