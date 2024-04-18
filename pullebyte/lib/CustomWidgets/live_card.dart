import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pullebyte/theme/colors.dart';

class LiveCard extends StatelessWidget {
  const LiveCard({super.key, this.dicTeams});

  final dynamic dicTeams;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customColorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 244,
        height: 135,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/pt/thumb/5/53/Arsenal_FC.svg/800px-Arsenal_FC.svg.png',
                  width: 48, // largura desejada da imagem
                  height: 48, // altura desejada da imagem
                  fit: BoxFit
                      .contain, // ajuste da imagem dentro do espaço fornecido
                ),
                SizedBox(height: 4),
                Text(
                  "Arsenal",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.background,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "1.2",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.background,
                  ),
                ),
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "3:2",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "89'",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg/800px-FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg.png',
                  width: 48, // largura desejada da imagem
                  height: 48, // altura desejada da imagem
                  fit: BoxFit
                      .contain, // ajuste da imagem dentro do espaço fornecido
                ),
                SizedBox(height: 4),
                Text(
                  "Bayern",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.background,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "1.7",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.background,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
