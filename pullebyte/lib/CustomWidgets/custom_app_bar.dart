import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';
import 'package:pullebyte/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String icon = 'lib/Assets/Icon_widget.svg';

  CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: LogoHeader(),
          ),
          Container(
            decoration: BoxDecoration(
              color: customColorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: 46,
              height: 46,
              child: IconButton(
                icon: SvgPicture.asset(
                  'lib/Assets/Icon_widget.svg',
                  color: customColorScheme.onPrimary,
                  fit: BoxFit.contain,
                  semanticsLabel: 'Icon',
                ),
                onPressed: () {
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
