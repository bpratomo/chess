import 'package:chess/models/piece.dart';

class Vector {
  final Function isLegalMove;
  final Function shouldContinue;
  int remainingTraversal;
  final int horizontalMovementSpeed;
  final int verticalMovementSpeed;

  Vector(
    this.isLegalMove,
    this.shouldContinue,
    this.remainingTraversal,
    this.horizontalMovementSpeed,
    this.verticalMovementSpeed,
  );

  Vector move() {
    final copy = this;
    copy.remainingTraversal -= 1;
    return copy;
  }
}

class VectorFactory {
  bool defaultIsLegalMoveCallback(
    String currentAddress,
    String nextAddress,
    Map<String, Piece?> positionToPieces,
    Piece pieceBeingConsidered,
    Vector vector,
  ) {
    final targetPiece = positionToPieces[nextAddress];
    if (targetPiece == null) return true;
    if (targetPiece.color == pieceBeingConsidered.color) return false;
    return true;
  }

  bool defaultShouldContinueCallback(int traversalDistance) {
    return traversalDistance > 0;
  }

  Vector defaultMethod(
    int horizontalMovementSpeed,
    int verticalMovementSpeed, {
    int traversalDistance = 999,
  }) {
    return Vector(
      defaultIsLegalMoveCallback,
      defaultShouldContinueCallback,
      traversalDistance,
      horizontalMovementSpeed,
      verticalMovementSpeed,
    );
  }

  Vector get south => defaultMethod(0, -1);
  Vector get north => defaultMethod(0, 1);
  Vector get west => defaultMethod(-1, 0);
  Vector get east => defaultMethod(1, 0);
  Vector get northWest => defaultMethod(-1, 1);
  Vector get northEast => defaultMethod(1, 1);
  Vector get southWest => defaultMethod(-1, -1);
  Vector get southEast => defaultMethod(-1, -1);

  Vector get knightNNW => defaultMethod(-1, 2, traversalDistance: 1);
  Vector get knightNWW => defaultMethod(-2, 1, traversalDistance: 1);
  Vector get knightNNE => defaultMethod(1, 2, traversalDistance: 1);
  Vector get knightNEE => defaultMethod(2, 1, traversalDistance: 1);
  Vector get knightSSW => defaultMethod(-1, -2, traversalDistance: 1);
  Vector get knightSWW => defaultMethod(-2, -1, traversalDistance: 1);
  Vector get knightSSE => defaultMethod(1, -2, traversalDistance: 1);
  Vector get knightSEE => defaultMethod(2, -1, traversalDistance: 1);
}
