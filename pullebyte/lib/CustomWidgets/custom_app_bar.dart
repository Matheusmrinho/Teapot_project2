import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';
import 'package:pullebyte/color_scheme_controller.dart';
import 'package:pullebyte/controller_database.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String icon = 'lib/Assets/Icon_widget.svg';
  final DatabaseController _databaseController = DatabaseController();
  CustomAppBar({super.key});

  void _logout(BuildContext context) async {
    _databaseController.signOut();
    Navigator.pushNamed(context, '/tela_login');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Provider.of<ColorSchemeController>(context).customColorScheme;
    return Container(
      height: 80,
      margin: const EdgeInsets.only(top: 50, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const LogoHeader(),
          ),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                icon: SvgPicture.asset(
                  'lib/Assets/Icon_widget.svg',
                  fit: BoxFit.contain,
                  semanticsLabel: 'Icon',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/tela_perfil');
                  // Adicione a ação que você deseja realizar ao clicar no ícone aqui
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
