import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/canhotos_card.dart';
import 'package:pullebyte/controller_canhotos.dart';

class CanhotosHolder extends StatefulWidget {
  const CanhotosHolder({super.key});

  @override
  _CanhotosHolderState createState() => _CanhotosHolderState();
}

class _CanhotosHolderState extends State<CanhotosHolder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CanhotosController>(context, listen: false).carregarFiltrosDoFirestore();
    });
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
              const SizedBox(height: 18),
              Column(
                children: [
                  context.watch<CanhotosController>().canhotosList.isEmpty
                      ? const Center(
                          child: Text('Nenhum canhoto cadastrado'),
                        )
                      : Column(
                          children: context.watch<CanhotosController>().canhotosList.map((canhoto) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CanhotosCard(
                                canhoto: canhoto,
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
