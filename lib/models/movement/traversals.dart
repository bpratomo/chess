import 'package:chess/models/piece.dart';
import 'package:chess/models/movement/direction.dart';
import 'package:chess/models/movement/address.dart';
import 'package:chess/models/state/position_state.dart';

class Traversals {
  static Set<String> generateLegalMoves(
    String startingAddress,
    Positions positions,
  ) {
    Set<String> generatedLegalMoves = {};
    Piece pieceBeingConsidered = positions.getConsideredPiece();
    final strategy = pieceBeingConsidered.strategy;
    if (strategy == null) {
      throw 'missing strategy for piece $pieceBeingConsidered';
    }

    for (final vector in strategy.vectors) {
      final legalMoves = _iter(
        vector,
        startingAddress,
        positions,
        {},
      );

      generatedLegalMoves.addAll(legalMoves);
    }

    return generatedLegalMoves;
  }

  static Set<String> _iter(
    Vector vector,
    String currentAddress,
    Positions positions,
    Set<String> traversed,
  ) {
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
      positions,
      vector
    )) {
      return traversed;
    }
//Case 2: if move legal, but should stop anyway, return updated traversal and stop
    final updatedTraversal = traversed;
    updatedTraversal.add(nextAddress);
    final shouldContinue = vector.shouldContinue(vector.remainingTraversalDistance);

    if (!shouldContinue) return updatedTraversal;

//Case 3: if everything should continue, then continue recursion
    return _iter(vector.move(), nextAddress, positions, updatedTraversal);
  }
}
