import 'package:flutter/material.dart';

class TimeItem extends StatelessWidget {
  final Map<String, dynamic> time;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TimeItem({
    Key? key,
    required this.time,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 164,
        height: 63,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 65, 65, 65),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 3,
            color: time['selecionado'] ? Colors.orange : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              time['escudoUrl'] ?? '',
              width: 40,
              height: 40,
            ),
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
  }
}
