import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pullebyte/Screens/canhotos.dart';
import 'package:pullebyte/Screens/insights.dart';
import 'package:pullebyte/Screens/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          Home(), // Tela de Jogos
          Canhotos(), // Tela de Canhotos
          Insights(), // Tela de Insights
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        color: const Color(0xff0f1821),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            backgroundColor: Color(0xff0f1821),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xffff6c27),
            gap: 10,
            padding: const EdgeInsets.all(14),
            tabs: const [
              GButton(
                icon: Icons.public,
                text: 'Jogos',
              ),
              GButton(
                icon: Icons.menu,
                text: 'Canhotos',
              ),
              GButton(
                icon: Icons.bar_chart,
                text: 'Insights',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
        ),
      ),
    );
  }
}
