import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/MainButton.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:pullebyte/CustomWidgets/Textinput.dart';
import 'package:pullebyte/CustomWidgets/Dropdown.dart';

class CanhotoModal extends StatelessWidget {
  const CanhotoModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: CustomColors.darkergrey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 125.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                height: 5.0,
                color: CustomColors.primaryColor,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0), // Adiciona padding
                    child: Text(
                      'Adicionar Canhoto',
                      style: TextStyle(
                        color: CustomColors.textColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFieldSample(
                    controller: TextEditingController(),
                    hintText: 'Título da aposta',
                    isSenha: false,
                  ),
                  SizedBox(height: 32.0),
                  TextFieldSample(
                    controller: TextEditingController(),
                    hintText: 'MM/DD/YY',
                    isSenha: false,
                  ),
                  SizedBox(height: 32.0),
                  TextFieldSample(
                    controller: TextEditingController(),
                    hintText: 'Valor apostado',
                    isSenha: false,
                  ),
                  SizedBox(height: 32.0),
                  TextFieldSample(
                    controller: TextEditingController(),
                    hintText: 'Time',
                    isSenha: false,
                  ),
                  SizedBox(height: 32.0),
                  Dropdown(
                    numeroDeOpcoes: ['Ganhou', 'Perdeu', 'Em Andamento'],
                    onChanged: (String value) {
                      print(value);
                    },
                  ),
                  SizedBox(height: 32.0),
                  Container(
                    height: 96,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.accentColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: CustomColors.textFieldColor,
                        size: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0), // Adiciona padding
                    child: MainButton(
                      text: 'Salvar',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
