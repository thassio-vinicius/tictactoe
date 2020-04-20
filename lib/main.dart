import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/providers/game_provider.dart';
import 'package:tictactoe/screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GameProvider>(create: (_) => GameProvider()),
    ],
    child: MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
