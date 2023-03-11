import 'package:chess/models/chess_graphics.dart';
import 'package:chess/models/movement/strategy.dart';

class EmptyPiece implements Piece {
  @override
  PieceStrategy? strategy;

  @override
  dynamic vectorIcon;

  @override
  String unit = 'none';

  @override
  String color = 'none';
}

class Piece {
  PieceStrategy? strategy;
  dynamic vectorIcon;
  String unit;
  String color;
  Piece(this.unit, this.color)
      : strategy = strategyMap[unit] ?? strategyMap['$color$unit'],
        vectorIcon = graphicsMap['$color$unit'];
}
