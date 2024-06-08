import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pullebyte/theme/colors.dart';

class FiltroTimeLogic {
  final List<Map<String, dynamic>> timesSelecionados = [];

  void adicionarTime(String nome, String escudoUrl, BuildContext context) {
    bool timeJaSelecionado =
        timesSelecionados.any((time) => time['nome'] == nome);
    if (!timeJaSelecionado) {
      timesSelecionados.add({
        'nome': nome,
        'escudoUrl': escudoUrl,
        'selecionado': false,
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

  void alternarSelecao(int index) {
    if (index >= 0 && index < timesSelecionados.length) {
      timesSelecionados[index]['selecionado'] =
          !timesSelecionados[index]['selecionado'];
    }
  }

  void excluirTime(int index) {
    if (index >= 0 && index < timesSelecionados.length) {
      timesSelecionados.removeAt(index);
    }
  }
}
