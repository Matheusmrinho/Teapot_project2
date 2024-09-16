import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/canhoto_modal.dart';
import 'package:pullebyte/color_scheme_controller.dart';

class AdicionarCanhotoButton extends StatelessWidget {
  const AdicionarCanhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Provider.of<ColorSchemeController>(context).customColorScheme;
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => CanhotoModal(),
        );
      },
      label: const Text(
        'Guardar\ncanhoto',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: const Icon(Icons.add, size: 20, weight: 900),
      backgroundColor: colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
