import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';

class Dropdown extends StatefulWidget {
  final List<String> numeroDeOpcoes;
  final Function(String) onChanged;

  const Dropdown({
    Key? key,
    required this.numeroDeOpcoes,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth * 0.85;
//
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 124, 64),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color.fromARGB(255, 252, 124, 64)),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                dropdownColor: customColorScheme.secondary,
                borderRadius: BorderRadius.circular(8.0),
                hint: Text(
                  'Situação',
                  style: TextStyle(color: Color.fromARGB(255, 248, 246, 246)),
                ),
                icon: const Icon(Icons.arrow_drop_down_sharp),
                iconSize: 24,
                elevation: 16,
                style:
                    const TextStyle(color: Color.fromARGB(255, 248, 246, 246)),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    widget.onChanged(dropdownValue!);
                  });
                },
                items: widget.numeroDeOpcoes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
