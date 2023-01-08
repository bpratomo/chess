import 'package:chess/models/piece.dart';

class Direction {
  final Function isLegalMove;
  final Function shouldContinueTraversal;
  var traversalDistance;
  final int horizontalMovementSpeed;
  final int verticalMovementSpeed;

  Direction(
      this.isLegalMove,
      this.shouldContinueTraversal,
      this.traversalDistance,
      this.horizontalMovementSpeed,
      this.verticalMovementSpeed);

bool defaultIsLegalMove(String address, Map<String, Piece?> positionToPieces,
      Piece pieceBeingConsidered) {
    final piece = positionToPieces[address];
    if (piece == null) return true;
    if (piece.color == pieceBeingConsidered.color) return false;
    return true;
  }

bool defaultShouldContinue(
      ) {

      return  false;

  } 

  Direction move(){
  final copy = this;
  copy.traversalDistance -=1;
  return copy;
  }

  Direction.standard(horizontalMovementSpeed, verticalMovementSpeed){
    return  Direction(defaultIsLegalMove, defaultShouldContinue, 999, horizontalMovementSpeed, verticalMovementSpeed)

  }
}

class DirectionFactory {
  bool defaultIsLegalMove(String address, Map<String, Piece?> positionToPieces,
      Piece pieceBeingConsidered) {
    final piece = positionToPieces[address];
    if (piece == null) return true;
    if (piece.color == pieceBeingConsidered.color) return false;
    return true;
  }

  bool defaultShouldContinue(
      String address, Map<String, Piece?> positionToPieces) {

  }

  DirectionFactory();

  final dirFactory = DirectionFactory();

  Direction defaultMethod(
      int horizontalMovementSpeed, int verticalMovementSpeed) {
    return Direction(defaultIsLegalMove, defaultShouldContinue, 999,
        horizontalMovementSpeed, verticalMovementSpeed);
  }

  Direction get south => defaultMethod(0, -1);
  Direction get north => defaultMethod(0, 1);
  Direction get west => defaultMethod(-1, 0);
  Direction get east => defaultMethod(1, 0);
  Direction get northWest => defaultMethod(-1, 1);
  Direction get northEast => defaultMethod(1, 1);
  Direction get southWest => defaultMethod(-1, -1);
  Direction get southEast => defaultMethod(-1, -1);

  Direction get knightNNW => defaultMethod(-1, 2);
  Direction get knightNWW => defaultMethod(-2, 1);
  Direction get knightNNE => defaultMethod(1, 2);
  Direction get knightNEE => defaultMethod(2, 1);
  Direction get knightSSW => defaultMethod(-1, -2);
  Direction get knightSWW => defaultMethod(-2, -1);
  Direction get knightSSE => defaultMethod(1, -2);
  Direction get knightSEE => defaultMethod(2, -1);
}
