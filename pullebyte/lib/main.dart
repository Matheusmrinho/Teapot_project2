import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pullebyte/CustomWidgets/filtro_time_logic.dart';
import 'package:pullebyte/Screens/tela_login.dart';
import 'package:pullebyte/controller_canhotos.dart';
import 'package:pullebyte/theme/colors.dart';
import 'package:pullebyte/CustomWidgets/NavigatorBar.dart';
import 'Screens/tela_cadastro.dart';
import 'Screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Screens/tela_perfil.dart';
import 'Screens/tela_recuperar_senha.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CanhotosController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FiltroTimeLogic(),
        ),
      ],
      child: MaterialApp(
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
          '/tela_login': (context) => LoginScreen(),
          '/tela_cadastro': (context) => CadastroScreen(),
          '/tela_recuperar_senha': (context) => PasswordRecoveryScreen(),
          '/home': (context) => const Scaffold(
                body: Home(),
                bottomNavigationBar: HomeScreen(),
              ),
          '/tela_perfil': (context) => ProfileScreen(),
        },
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}