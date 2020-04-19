import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///C:/Users/Usuario/AndroidStudioProjects/tictactoe/lib/providers/players_provider.dart';
import 'file:///C:/Users/Usuario/AndroidStudioProjects/tictactoe/lib/screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PlayersProvider()),
    ],
    child: MaterialApp(
      home: HomeScreen(),
    ),
  ));
}
