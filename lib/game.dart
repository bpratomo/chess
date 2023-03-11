import 'package:chess/board.dart';
import 'package:chess/models/positions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => Board(),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [BoardRenderer()],
        ),
      ),
    );
  }
}
