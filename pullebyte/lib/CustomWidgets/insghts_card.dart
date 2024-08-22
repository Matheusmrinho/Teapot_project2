import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';

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
    return Stack(
      children: [
        Container(
          width: 222.0,
          height: 130.0,
          decoration: BoxDecoration(
            color: CustomColors.primaryColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
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
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  conteudo,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                    color: CustomColors.textColor,
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
            backgroundColor: CustomColors.primaryColor,
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
