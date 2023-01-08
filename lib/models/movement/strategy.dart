import 'package:chess/models/movement/direction.dart';

final strategyMap = <String, PieceStrategy>{
  'rook': RookStrategy(),
  'knight': KnightStrategy(),
  'queen': QueenStrategy(),
  'king': KingStrategy(),
  'bishop': BishopStrategy()
};

abstract class PieceStrategy {
  DirectionFactory dirFactory = DirectionFactory();
  List<Direction> vectors = [];
}

class KnightStrategy extends PieceStrategy {
  @override
  late List<Direction> vectors = [
    dirFactory.knightSEE,
    dirFactory.knightSSE,
    dirFactory.knightNNW,
    dirFactory.knightNWW,
    dirFactory.knightNEE,
    dirFactory.knightNNE,
    dirFactory.knightSSW,
    dirFactory.knightSWW,
  ];
}

class KingStrategy extends PieceStrategy {
  @override
  late List<Direction> vectors = [
    dirFactory.north,
    dirFactory.south,
    dirFactory.west,
    dirFactory.east,
    dirFactory.northWest,
    dirFactory.northEast,
    dirFactory.southWest,
    dirFactory.southEast,
  ];
}

class QueenStrategy extends PieceStrategy {
  @override
  late List<Direction> vectors = [
    dirFactory.north,
    dirFactory.south,
    dirFactory.west,
    dirFactory.east,
    dirFactory.northWest,
    dirFactory.northEast,
    dirFactory.southWest,
    dirFactory.southEast,
  ];
}

class BishopStrategy extends PieceStrategy {
  @override
  late List<Direction> vectors = [
    dirFactory.northWest,
    dirFactory.northEast,
    dirFactory.southWest,
    dirFactory.southEast,
  ];
}

class RookStrategy extends PieceStrategy {
  @override
  late List<Direction> vectors = [
    dirFactory.north,
    dirFactory.south,
    dirFactory.west,
    dirFactory.east,
  ];
}
