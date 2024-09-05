import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pullebyte/theme/colors.dart';

class Dropdown extends StatefulWidget {
  final List<String> numeroDeOpcoes;
  final Function(String) onChanged;
  final double inputWidth;
  final String? hintText;

  const Dropdown({
    super.key,
    required this.numeroDeOpcoes,
    required this.onChanged,
    this.inputWidth = 0.85,
    this.hintText = 'Selecione',
  });

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth * widget.inputWidth;
//
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: customColorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: customColorScheme.onPrimary),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                dropdownColor: customColorScheme.onPrimary,
                borderRadius: BorderRadius.circular(8.0),
                hint: Text(
                  widget.hintText!,
                  style: TextStyle(
                      color: customColorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                icon: Icon(FeatherIcons.chevronDown,
                    color: customColorScheme.secondary),
                iconSize: 20,
                elevation: 16,
                style: TextStyle(
                    color: customColorScheme.secondary,
                    fontWeight: FontWeight.w600),
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
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
