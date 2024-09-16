import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/color_scheme_controller.dart';

class InsghtsCard extends StatelessWidget {
  final String titulo;
  final String conteudo;
  final IconData? icone;

  const InsghtsCard({
    Key? key,
    required this.titulo,
    required this.conteudo,
    this.icone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Provider.of<ColorSchemeController>(context).customColorScheme;
    return Stack(
      children: [
        Container(
          // constraints: const BoxConstraints(maxWidth: 80),
          width: 222.0,
          height: 145.0,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: CustomColors.darkergrey,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icone != null)
                      Icon(
                        icone,
                        size: 20.0,
                        color: CustomColors.textColor,
                      ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  conteudo,
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    color: CustomColors.textColor,
                    // overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: CircleAvatar(
            radius: 8.0,
            backgroundColor: colorScheme.primary,
            child: Icon(
              Icons.info,
              size: 16.0,
              color: CustomColors.textColor,
            ),
          ),
        ),
      ],
    );
  }
}
