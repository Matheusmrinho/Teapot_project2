import 'package:flutter/material.dart';
import 'package:pullebyte/color_scheme_controller.dart';

//serach bar for canhotos com o hint a esquerda do widget "Buscar canhotos" e um icone de lupa a direita com o color gray

class CanhotosSearchBar extends StatelessWidget {
  const CanhotosSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: CustomColors.darkergrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar canhotos',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 168, 165, 158),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: Color.fromARGB(255, 168, 165, 158),
            //alinhado a direita da row
          ),
        ],
      ),
    );
  }
}
