import 'package:chess/models/movement/direction.dart';
import 'package:chess/models/movement/pieceSpecificLogic/pawn_vector_factory.dart';

final strategyMap = <String, PieceStrategy>{
  'rook': RookStrategy(),
  'knight': KnightStrategy(),
  'queen': QueenStrategy(),
  'king': KingStrategy(),
  'bishop': BishopStrategy(),
  'blackpawn': BlackPawnStrategy(),
  'whitepawn': WhitePawnStrategy(),
};

class PieceStrategy {
  VectorFactory vectorFactory = VectorFactory();
  List<Vector> vectors = [];
}

class KnightStrategy implements PieceStrategy {
  @override
  VectorFactory vectorFactory = VectorFactory();

  @override
  late List<Vector> vectors = [
    vectorFactory.knightSEE,
    vectorFactory.knightSSE,
    vectorFactory.knightNNW,
    vectorFactory.knightNWW,
    vectorFactory.knightNEE,
    vectorFactory.knightNNE,
    vectorFactory.knightSSW,
    vectorFactory.knightSWW,
  ];
}

class KingStrategy implements PieceStrategy {
  @override
  VectorFactory vectorFactory = VectorFactory();

  @override
  late List<Vector> vectors = [
    vectorFactory.northOne,
    vectorFactory.southOne,
    vectorFactory.westOne,
    vectorFactory.eastOne,
    vectorFactory.northWestOne,
    vectorFactory.northEastOne,
    vectorFactory.southWestOne,
    vectorFactory.southEastOne,
  ];
}

class QueenStrategy implements PieceStrategy {
  @override
  VectorFactory vectorFactory = VectorFactory();

  @override
  late List<Vector> vectors = [
    vectorFactory.north,
    vectorFactory.south,
    vectorFactory.west,
    vectorFactory.east,
    vectorFactory.northWest,
    vectorFactory.northEast,
    vectorFactory.southWest,
    vectorFactory.southEast,
  ];
}

class BishopStrategy implements PieceStrategy {
  @override
  VectorFactory vectorFactory = VectorFactory();

  @override
  late List<Vector> vectors = [
    vectorFactory.northWest,
    vectorFactory.northEast,
    vectorFactory.southWest,
    vectorFactory.southEast,
  ];
}

class RookStrategy implements PieceStrategy {
  @override
  VectorFactory vectorFactory = VectorFactory();

  @override
  late List<Vector> vectors = [
    vectorFactory.north,
    vectorFactory.south,
    vectorFactory.west,
    vectorFactory.east,
  ];
}

class WhitePawnStrategy implements PieceStrategy {
  @override
  VectorFactory vectorFactory = VectorFactory();

  @override
  late List<Vector> vectors = [
    vectorFactory.pawnWhiteAttackLeft,
    vectorFactory.pawnWhiteAttackRight,
    vectorFactory.pawnWhiteTwoJump,
    vectorFactory.pawnWhiteNormalMove,
  ];
}

class BlackPawnStrategy implements PieceStrategy {
  @override
  VectorFactory vectorFactory = VectorFactory();

  @override
  late List<Vector> vectors = [
    vectorFactory.pawnBlackAttackLeft,
    vectorFactory.pawnBlackAttackRight,
    vectorFactory.pawnBlackTwoJump,
    vectorFactory.pawnBlackNormalMove,
  ];
}
