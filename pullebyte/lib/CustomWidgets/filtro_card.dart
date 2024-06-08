import 'package:flutter/material.dart';

class TimeItem extends StatelessWidget {
  final String nome;
  final String escudo;
  final VoidCallback onTap;
  final Function(bool isSelected)? changeState;
  final bool isItemSelected;

  const TimeItem({
    Key? key,
    required this.nome,
    required this.escudo,
    required this.onTap,
    required this.isItemSelected,
    this.changeState, required Null Function() onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeState!(!isItemSelected),
    //   onLongPress: () {

    //   },
      child: Container(
        width: 180,
        height: 80,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 17, 17, 17),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isItemSelected ? Colors.deepOrange : Colors.transparent,
                width: 2)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nome),
              SizedBox(width: 20),
              Image.network(
                escudo,
                width: 50,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}