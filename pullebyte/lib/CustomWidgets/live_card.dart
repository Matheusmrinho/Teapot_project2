import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pullebyte/theme/colors.dart';

class LiveCard extends StatelessWidget {
  const LiveCard({super.key, required this.jsonData});
  final String jsonData;

  String getEscudoImageUrl(String id) {
    return 'https://arquivos.admsuperplacar.com.br/img_${id}_48.png';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = jsonDecode(jsonData);
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
                  getEscudoImageUrl(data['ImgMand']),
                  width: 48, // largura desejada da imagem
                  height: 48, // altura desejada da imagem
                  fit: BoxFit.contain, // ajuste da imagem dentro do espaço fornecido
                ),
                const SizedBox(height: 4),
                Container(
                  constraints: const BoxConstraints(maxWidth: 80), // Defina o tamanho máximo desejado
                  child: Text(
                    "${data['EquipeMand']}" ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: customColorScheme.onPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "1.2",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 4),
                Text(
                  "${data['GolsMand']}:${data['GolsAdv']}" ?? '', // Corrigido aqui
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.onPrimary,
                  ),
                ),
                Text(
                  "${data['Hora'].substring(0, 2)}'" ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '1.7',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  getEscudoImageUrl(data['ImgAdv']),
                  width: 48, // largura desejada da imagem
                  height: 48, // altura desejada da imagem
                  fit: BoxFit.contain, // ajuste da imagem dentro do espaço fornecido
                ),
                const SizedBox(height: 4),
                Container(
                  constraints: const BoxConstraints(maxWidth: 80), // Defina o tamanho máximo desejado
                  child: Text(
                    "${data['EquipeAdv']}" ?? '', // Corrigido aqui
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: customColorScheme.onPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "1.7",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: customColorScheme.onPrimary,
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
