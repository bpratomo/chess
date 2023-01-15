import 'package:chess/models/piece.dart';
import 'package:chess/models/movement/direction.dart';
import 'package:chess/models/movement/address.dart';
import 'package:chess/models/movement/strategy.dart';

bool checkMoveLegality(String address, Function directionIsLegalCallback,
    Map<String, Piece?> positionToPieces, pieceBeingConsidered) {
  if (address.contains('null')) return false;

  final isAddressValidResult = isAddressValid(address);
  final isDirectionLegal =
      directionIsLegalCallback(address, positionToPieces, pieceBeingConsidered);

  print(
      'isAddressValidResult $isAddressValidResult & isDirectionLegal $isDirectionLegal');

  return isAddressValid(address) &&
      directionIsLegalCallback(address, positionToPieces, pieceBeingConsidered);
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
      print('=====================================================');
      final directionPathways = _iter(direction, address, positionToPieces, {},
          pieceBeingConsidered, strategy);
      generatedPathways.addAll(directionPathways);

      print('=====================================================');
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
    print(
        'running iter with traversed $traversed and directions ${direction.verticalMovementSpeed}');

    print(
        'retrieving horizontal address for ${currentAddress.substring(0, 1)} ');

// Calculate updated traversal map, if move to be taken
    final newAddress = calculateNewAddress(currentAddress,
        direction.verticalMovementSpeed, direction.horizontalMovementSpeed);
    print('retrieved new address is $newAddress');

// Assess which traversal map to return
//Case 1: if move is not legal, then stop and return previous traversals
    final isMoveLegal = checkMoveLegality(newAddress, direction.isLegalMove,
        positionToPieces, pieceBeingConsidered);
    print('isMoveLegal $isMoveLegal');
    if (!isMoveLegal) return traversed;

//Case 2: if move legal, but should stop anyway, return updated traversal and stop
    final newTraversed = traversed;
    newTraversed[newAddress] = true;
    final isShouldContinue =
        direction.shouldContinueTraversal(direction.traversalDistance);

    if (!isShouldContinue) return newTraversed;

//Case 3: if everything should continue, then continue recursion
    return _iter(direction.move(), newAddress, positionToPieces, newTraversed,
        pieceBeingConsidered, strategy);
  }
}
