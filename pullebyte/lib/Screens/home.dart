import 'package:flutter/material.dart';
import 'package:pullebyte/CustomWidgets/logo_header.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
  body: SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
            child: LogoHeader(),
          ),
        ),
        Container(height: screenHeight * 0.5),
        GestureDetector(
          onTap: () {
            // Resto do código...
          },
          child: Text(
            'Jogos Futuros',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 100),
  height: 300, // Defina a altura que você deseja para o ListView.builder
  child: ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0), // Adiciona um padding de 8 pixels
        child: Card(
          child: ListTile(
            title: index == 0 ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('lib/Assets/i.png', width: 50, height: 50),
                  Image.asset('lib/Assets/FC_Bayern_München_logo_(2017).svg.png', width: 50, height: 50),
                ],
              )
              : null,
          ),
        ),
      );
    },
  ),
),
      ],
    ),
  ),
);
  }
}