import 'package:bulletin_board_app/screens/login_screen.dart';
import 'package:bulletin_board_app/screens/registration_screen.dart';
import 'package:bulletin_board_app/screens/thread_list_screen.dart';
import 'package:bulletin_board_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BulletinBoard());
}

class BulletinBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ThreadListScreen.id: (context) => ThreadListScreen(),
      },
    );
  }
}
