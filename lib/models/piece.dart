import 'package:chess/models/chess_graphics.dart';
import 'package:chess/models/movement/strategy.dart';

class Piece {
  PieceStrategy? strategy;
  dynamic vectorIcon;
  String unit;
  String color;
  Piece(this.unit, this.color)
      : strategy = strategyMap[unit],
        vectorIcon = graphicsMap['$color$unit'];
}

