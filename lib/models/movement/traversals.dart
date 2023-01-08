import 'package:chess/models/piece.dart';
import 'package:chess/models/movement/direction.dart';
import 'package:chess/models/movement/address.dart';
import 'package:chess/models/movement/strategy.dart';

bool isMoveLegal(String address, Function directionIsLegalCallback,
    Map<String, Piece?> positionToPieces) {
  return isAddressValid(address) &&
      directionIsLegalCallback(address, positionToPieces);
}

class Traversals {
  static Map<String, bool> generatePathways(String address,
      Piece pieceBeingConsidered, Map<String, Piece?> positionToPieces) {
    print('starting pathway generation for ${pieceBeingConsidered.unit}');
    final strategy = strategyMap[pieceBeingConsidered.unit];
    if (strategy == null) {
      throw 'invalid piece!';
    }

    Map<String, bool> generatedPathways = {};

    for (final direction in strategy.vectors) {
      final directionPathways = _iter(direction, address, positionToPieces, {},
          pieceBeingConsidered, strategy);
      generatedPathways.addAll(directionPathways);
    }
    print('generatedPathways is $generatedPathways');

    return generatedPathways;
  }

  static Map<String, bool> _iter(
      Direction direction,
      String currentAddress,
      Map<String, Piece?> positionToPieces,
      Map<String, bool> traversed,
      Piece pieceBeingConsidered,
      PieceStrategy strategy) {
    print('running iter with traversed $traversed and directions $direction');

    print(
        'retrieving horizontal address for ${currentAddress.substring(0, 1)} ');

    final newAddress = calculateNewAddress(currentAddress, 1, 1);
    final isLegalMove =
        isMoveLegal(newAddress, direction.isLegalMove, positionToPieces);
    if (!isLegalMove) return traversed;
    final newTraversed = traversed;
    newTraversed[newAddress] = true;

    final isTraversalOver = !direction.shouldContinueTraversal();
    if (!isTraversalOver) return newTraversed;
    return _iter(direction.move(), newAddress, positionToPieces, newTraversed,
        pieceBeingConsidered, strategy);
  }
}
