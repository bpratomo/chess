import 'package:chess/game.dart';
import 'package:flutter/material.dart';
import 'package:stockfish/stockfish.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  late Stockfish stockfish;
  late Stream<String> stream;

  @override
  void initState() {
    super.initState();
    stockfish = Stockfish();
    stream = stockfish.stdout;
    stream.listen((command) {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stockfish example app'),
        ),
        body: const Game(),
      ),
    );
  }
}
