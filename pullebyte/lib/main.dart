import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pullebyte/CustomWidgets/custom_app_bar.dart';
import 'package:pullebyte/Screens/tela_login.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:pullebyte/CustomWidgets/NavigatorBar.dart';
import 'Screens/tela_cadastro.dart';
import 'Screens/home.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Defina a variável icon aqui ou forneça diretamente dentro do AppBar
  
  runApp(MaterialApp(
    title: 'Pullebyte',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: customColorScheme.onPrimary,
      ),
      colorScheme: customColorScheme,
      useMaterial3: true,
    ),
    initialRoute: '/tela_login',
    routes: {
      '/tela_login': (context) => const TelaLogin(),
      '/tela_cadastro': (context) => const TelaCadastro(),
      '/home': (context) => const Scaffold(
        body: Home(),
        bottomNavigationBar: HomeScreen(),
      ),
    },
  ));
}
