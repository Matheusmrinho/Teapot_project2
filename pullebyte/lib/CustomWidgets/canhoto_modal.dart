import 'package:flutter/material.dart';
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Text(
                  'Adicionar Canhoto',
                  style: TextStyle(
                    color: CustomColors.textColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFieldSample(
                        controller: TextEditingController(),
                        hintText: 'Time 1',
                        isSenha: false,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Dropdown(
                        numeroDeOpcoes: ['1', 'X', '2'],
                        onChanged: (String value) {
                          print(value);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Adicione mais widgets aqui se necessário.
        ],
      ),
    );
  }
}
