import 'package:chess/models/piece.dart';
import 'package:chess/models/movement/direction.dart';
import 'package:chess/models/movement/address.dart';
import 'package:chess/models/movement/strategy.dart';

class Traversals {
  static Map<String, bool> generateLegalMoves(String address,
      Piece pieceBeingConsidered, Map<String, Piece?> positionToPieces) {
    Map<String, bool> generatedLegalMoves = {};
    final strategy = pieceBeingConsidered.strategy;
    if (strategy == null) {
      throw 'missing strategy for piece $pieceBeingConsidered';
    }

    for (final direction in strategy.vectors) {
      final legalMoves = _iter(direction, address, positionToPieces, {},
          pieceBeingConsidered, strategy);

      generatedLegalMoves.addAll(legalMoves);
    }

    return generatedLegalMoves;
  }

  static Map<String, bool> _iter(
      Vector vector,
      String currentAddress,
      Map<String, Piece?> positionToPieces,
      Map<String, bool> traversed,
      Piece pieceBeingConsidered,
      PieceStrategy strategy) {
// Calculate updated traversal map, if move to be taken
    final nextAddress = calculateNextAddress(
      currentAddress,
      vector.verticalMovementSpeed,
      vector.horizontalMovementSpeed,
    );

// Assess which traversal map to return
//Case 1: if move is not legal, then stop and return previous traversals
    if (!isAddressValid(nextAddress)) return traversed;
    if (!vector.isLegalMove(
      currentAddress,
      nextAddress,
      positionToPieces,
      pieceBeingConsidered,
      vector,
    )) {
      return traversed;
    }
//Case 2: if move legal, but should stop anyway, return updated traversal and stop
    final updatedTraversal = traversed;
    updatedTraversal[nextAddress] = true;
    final shouldContinue = vector.shouldContinue(vector.remainingTraversal);

    if (!shouldContinue) return updatedTraversal;

//Case 3: if everything should continue, then continue recursion
    return _iter(vector.move(), nextAddress, positionToPieces, updatedTraversal,
        pieceBeingConsidered, strategy);
  }
}
