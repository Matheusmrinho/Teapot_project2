import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';

// class Dropdown extends StatefulWidget {
//   const Dropdown({ Key? key }) : super(key: key);

//   @override
//   _DropdownState createState() => _DropdownState();
// }

// class _DropdownState extends State<Dropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

//faça um dropdown com estrutura similar a cima, mas que receba com argumento o numero de opcões para colocar no dropdown
//e que retorne o valor selecionado
class Dropdown extends StatefulWidget {
  //numero de opções sera uma lista
  final List<String> numeroDeOpcoes;
  final Function(String) onChanged;
  const Dropdown(
      {Key? key, required this.numeroDeOpcoes, required this.onChanged})
      : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_sharp),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: CustomColors.textColor),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          widget.onChanged(dropdownValue);
        });
      },
      items:
          widget.numeroDeOpcoes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
