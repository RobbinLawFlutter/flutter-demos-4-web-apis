import 'package:flutter/material.dart';
import 'package:flash_chat_again/screens/welcome_screen.dart';
import 'package:flash_chat_again/screens/login_screen.dart';
import 'package:flash_chat_again/screens/registration_screen.dart';
import 'package:flash_chat_again/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) {
          return WelcomeScreen();
        },
        LoginScreen.id: (context) {
          return LoginScreen();
        },
        RegistrationScreen.id: (context) {
          return RegistrationScreen();
        },
        ChatScreen.id: (context) {
          return ChatScreen();
        },
      },
    );
  }
}
