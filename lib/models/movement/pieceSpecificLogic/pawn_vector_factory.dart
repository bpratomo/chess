import 'package:chess/models/movement/address.dart';
import 'package:chess/models/movement/direction.dart';
import 'package:chess/models/state/position_state.dart';

extension PawnVectorFactory on VectorFactory {
  bool isDiagonalAttackLegal(
    String currentAddress,
    String nextAddress,
    Positions positions,
    Vector vector,
  ) {
    final currentPiece = positions.getConsideredPiece();
    final targetPiece = positions.getPiece(nextAddress);
    if (targetPiece == null) return false;
    if (targetPiece.color == currentPiece.color) return false;

    return true;
  }

  bool isTwoMoveJumpLegal(
    String currentAddress,
    String nextAddress,
    Positions positions,
    Vector vector,
  ) {
    final currentPiece = positions.getConsideredPiece();
    if (positions.pieceHasMoved(currentPiece.uuid)) {
      return false;
    }

    final targetPiece = positions.getPiece(nextAddress);

    final goingUp = vector.verticalMovementSpeed > 0;
    final addressAfterJump = goingUp
        ? calculateNextAddress(positions.considerationStartingPoint, 1, 0)
        : calculateNextAddress(positions.considerationStartingPoint, -1, 0);

    final obstructingPiece = positions.getPiece(addressAfterJump);

    if (targetPiece != null) return false;
    if (obstructingPiece != null) return false;
    return true;
  }

  Vector createDiagonalAttackVector(
    String color,
    int horizontalMovementSpeed,
  ) {
    final verticalDirection = color == 'black' ? -1 : 1;

    return Vector(
      isDiagonalAttackLegal,
      defaultShouldContinueCallback,
      1,
      horizontalMovementSpeed,
      1 * verticalDirection,
    );
  }

  Vector createTwoJumpVector(String color) {
    final verticalDirection = color == 'black' ? -1 : 1;
    return Vector(
      isTwoMoveJumpLegal,
      defaultShouldContinueCallback,
      0,
      0,
      2 * verticalDirection,
    );
  }

  Vector createPawnNormalMove(String color) {
    final verticalDirection = color == 'black' ? -1 : 1;
    return defaultMethod(
      0,
      verticalDirection,
      traversalDistance: 1,
    );
  }

  Vector get pawnWhiteAttackLeft => createDiagonalAttackVector('white', 1);
  Vector get pawnWhiteAttackRight => createDiagonalAttackVector('white', -1);
  Vector get pawnBlackAttackLeft => createDiagonalAttackVector('black', 1);
  Vector get pawnBlackAttackRight => createDiagonalAttackVector('black', -1);

  Vector get pawnWhiteTwoJump => createTwoJumpVector('white');
  Vector get pawnBlackTwoJump => createTwoJumpVector('black');

  Vector get pawnWhiteNormalMove => createPawnNormalMove('white');
  Vector get pawnBlackNormalMove => createPawnNormalMove('black');
}
