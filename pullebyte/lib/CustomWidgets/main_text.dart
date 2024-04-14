import 'package:flutter/material.dart';
import 'package:pullebyte/theme/colors.dart';

class LinkAndText extends StatelessWidget {
  final String? text;
  final String? linkText;
  final String? route;
  final MainAxisAlignment? alignment;

  const LinkAndText({
    Key? key,
    required this.text,
    required this.linkText,
    required this.route,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.center,
        children: [
          Text(text!),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route!);
            },
            child: Text(
              linkText!,
              style: const TextStyle(
                color: CustomColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
