import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/color_scheme_controller.dart';

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
    final colorScheme = Provider.of<ColorSchemeController>(context).customColorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth * widget.inputWidth;
//
    return Container(
      width: width,
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colorScheme.onPrimary),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: dropdownValue,
                dropdownColor: colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(8.0),
                hint: Text(
                  widget.hintText!,
                  style: TextStyle(
                      color: colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                icon: Icon(FeatherIcons.chevronDown,
                    color: colorScheme.secondary),
                iconSize: 20,
                elevation: 16,
                style: TextStyle(
                    color: colorScheme.secondary,
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
