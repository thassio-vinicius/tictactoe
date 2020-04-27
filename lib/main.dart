import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/authentication_provider.dart';
import 'package:tictactoe/providers/game_provider.dart';
import 'package:tictactoe/screens/background_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GameProvider>(create: (_) => GameProvider()),
      ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider())
    ],
    child: MaterialApp(
      home: BackgroundScreen(screens: Screens.initialScreen),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
