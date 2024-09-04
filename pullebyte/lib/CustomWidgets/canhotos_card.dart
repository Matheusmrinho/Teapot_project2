import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/canhoto_modal.dart';
import 'package:pullebyte/controller_canhotos.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CanhotosCard extends StatefulWidget {
  final Map<String, dynamic> canhoto;

  const CanhotosCard({super.key, required this.canhoto});

  @override
  _CanhotosCardState createState() => _CanhotosCardState();
}

String getEscudoImageUrl(String id) {
  return 'https://pullebyte.onrender.com/get_escudo_image/$id';
}

class _CanhotosCardState extends State<CanhotosCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    final Timestamp timestamp = widget.canhoto['pulleDate'] as Timestamp;
    final DateTime dateTime = timestamp.toDate();

    // Formata a data
    String mes = DateFormat("MMM", "pt_BR").format(dateTime);
    mes = mes[0].toUpperCase() + mes.substring(1);
    final dataFormatada = '$mes ${dateTime.day}, ${dateTime.year}';

    final screenWidth = MediaQuery.of(context).size.width;

    final width = screenWidth * 0.85;
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: customColorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: width,
          height: 155,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dataFormatada,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: customColorScheme.secondary, width: 5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              imageUrl: getEscudoImageUrl(widget.canhoto['pulleChosenTeamID']),
                              fit: BoxFit.cover,
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 80),
                          child: Text(
                            widget.canhoto['pulleChosenTeam'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: customColorScheme.onPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8), // Arredonda os cantos do container
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'R\$ ${widget.canhoto['pulleValue']}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CachedNetworkImage(
                  width: width / 2.5,
                  height: 155,
                  imageUrl: "",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        CanhotoModal();
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Excluir Canhoto?'),
              content: Text('Deseja excluir o canhoto: ${widget.canhoto['pulleTitle']}?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<CanhotosController>().deleteCanhoto(widget.canhoto['id']);
                    Navigator.pop(context);
                  },
                  child: const Text('Excluir'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
