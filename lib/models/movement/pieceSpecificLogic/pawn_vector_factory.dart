import 'package:chess/models/movement/address.dart';
import 'package:chess/models/piece.dart';
import 'package:chess/models/movement/direction.dart';

extension PawnVectorFactory on VectorFactory {
  bool isDiagonalAttackLegal(
    String currentAddress,
    String nextAddress,
    Map<String, Piece?> positionToPieces,
    Piece pieceBeingConsidered,
    Vector vector,
  ) {
    final currentPiece = positionToPieces[currentAddress];
    final targetPiece = positionToPieces[nextAddress];
    if (targetPiece == null || currentPiece == null) return false;
    if (targetPiece.color == currentPiece.color) return false;

    return true;
  }

  bool isTwoMoveJumpLegal(
    String currentAddress,
    String nextAddress,
    Map<String, Piece?> positionToPieces,
    Piece pieceBeingConsidered,
    Vector vector,
  ) {
    final currentPiece = positionToPieces[currentAddress];
    final targetPiece = positionToPieces[nextAddress];

    final goingUp = vector.verticalMovementSpeed > 0;
    final middleAddress = goingUp
        ? calculateNextAddress(currentAddress, 1, 0)
        : calculateNextAddress(currentAddress, -1, 0);

    final obstructingPiece = positionToPieces[middleAddress];

    if (currentPiece == null) return false;
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
      1,
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
