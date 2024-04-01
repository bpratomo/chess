import 'package:chess/models/state/position_state.dart';

class Vector {
  final Function(String, String, Positions, Vector) isLegalMove;
  final Function shouldContinue;
  int remainingTraversalDistance;
  final int horizontalMovementSpeed;
  final int verticalMovementSpeed;

  Vector(
    this.isLegalMove,
    this.shouldContinue,
    this.remainingTraversalDistance,
    this.horizontalMovementSpeed,
    this.verticalMovementSpeed,
  );

  Vector move() {
    final copy = this;
    copy.remainingTraversalDistance -= 1;
    return copy;
  }
}

class VectorFactory {
  bool defaultIsLegalMoveCallback(
    String currentAddress,
    String nextAddress,
    Positions positions,
    Vector vector,
  ) {
    final pieceBeingConsidered = positions.getConsideredPiece();
    final targetPiece = positions.getPiece(nextAddress);
    if (targetPiece == null) return true;
    if (targetPiece.color == pieceBeingConsidered.color) return false;
    return true;
  }

  bool defaultShouldContinueCallback(int remainingTraversalDistance) {
    return remainingTraversalDistance > 0;
  }

  Vector defaultMethodOne(
      int horizontalMovementSpeed, int verticalMovementSpeed) {
    return defaultMethod(
      horizontalMovementSpeed,
      verticalMovementSpeed,
      traversalDistance: 0,
    );
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
  Vector get southEast => defaultMethod(1, -1);

  Vector get southOne => defaultMethodOne(0, -1);
  Vector get northOne => defaultMethodOne(0, 1);
  Vector get westOne => defaultMethodOne(-1, 0);
  Vector get eastOne => defaultMethodOne(1, 0);
  Vector get northWestOne => defaultMethodOne(-1, 1);
  Vector get northEastOne => defaultMethodOne(1, 1);
  Vector get southWestOne => defaultMethodOne(-1, -1);
  Vector get southEastOne => defaultMethodOne(-1, -1);

  Vector get knightNNW => defaultMethod(-1, 2, traversalDistance: 0);
  Vector get knightNWW => defaultMethod(-2, 1, traversalDistance: 0);
  Vector get knightNNE => defaultMethod(1, 2, traversalDistance: 0);
  Vector get knightNEE => defaultMethod(2, 1, traversalDistance: 0);
  Vector get knightSSW => defaultMethod(-1, -2, traversalDistance: 0);
  Vector get knightSWW => defaultMethod(-2, -1, traversalDistance: 0);
  Vector get knightSSE => defaultMethod(1, -2, traversalDistance: 0);
  Vector get knightSEE => defaultMethod(2, -1, traversalDistance: 0);
}
