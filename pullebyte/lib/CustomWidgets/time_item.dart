import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/color_scheme_controller.dart';

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
    final colorScheme = Provider.of<ColorSchemeController>(context).customColorScheme;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 164,
        height: 63,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 65, 65, 65),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 3,
            color: time['selecionado'] ? colorScheme.primary : Colors.transparent,
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
            SizedBox(
                width: 85,
                child: Text(
                  time['nome'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
