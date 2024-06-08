import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/ShowModal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pullebyte/theme/colors.dart';

class FiltroTime extends StatefulWidget {
  const FiltroTime({Key? key}) : super(key: key);

  @override
  _FiltroTimeState createState() => _FiltroTimeState();
}

class _FiltroTimeState extends State<FiltroTime> {
  List<Map<String, dynamic>> timesSelecionados = [];

  void _adicionarTime(String nome, String escudoUrl) {
  bool timeJaSelecionado =
      timesSelecionados.any((time) => time['nome'] == nome);
  if (!timeJaSelecionado) {
    setState(() {
      timesSelecionados.add({
        'nome': nome,
        'escudoUrl': escudoUrl,
        'selecionado': false,
      });
    });
  } else {
    Fluttertoast.showToast(
      webBgColor: CustomColors.buttonColor,
      msg: 'O time $nome já foi selecionado.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 4,
      backgroundColor: CustomColors.buttonColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

  void _alternarSelecao(int index) {
  if (index >= 0 && index < timesSelecionados.length) {
    setState(() {
      timesSelecionados[index]['selecionado'] =
          !timesSelecionados[index]['selecionado'];
    });
  }
}

  void _excluirTime(int index) {
    setState(() {
      timesSelecionados.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...timesSelecionados.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> time = entry.value;
              return GestureDetector(
                onTap: () {
                  _alternarSelecao(index);
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Excluir Filtro?'),
                        content:
                            Text('Deseja excluir o Filtro ${time['nome']}?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              _excluirTime(index);
                              Navigator.pop(context);
                            },
                            child: const Text('Excluir'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 180,
                  height: 70,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 65, 65, 65),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 3,
                      color: time['selecionado']
                          ? Colors.orange
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        time['escudoUrl'] ?? '',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        time['nome'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            MeuModalWidget(
              onItemSelected: _adicionarTime,
            ),
          ],
        ),
      ),
    );
  }
}
