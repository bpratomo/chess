import 'package:chess/models/piece.dart';
import 'package:chess/models/state/position_state.dart';
import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  GameState()
      : _currentTurn = 'white',
        positions = Positions();

  Positions positions;

  String _currentTurn = '';
// Entry point of user interaction
  void clickHandler(String address) {
    final piece = positions.getPiece(address);
    print('handling click');

    // Return early if it's not the right color's turn
    if (positions.getConsideredPiece() is EmptyPiece &&
        piece?.color != _currentTurn) {
      _clearPositionConsideration();
      return;
    }

    bool isUpdated;

    if (positions.considerationStartingPoint.isEmpty) {
      isUpdated = considerPosition(address);
    } else {
      isUpdated = movePiece(address);
    }

    if (isUpdated) {
      notifyListeners();
    }
    return;
  }

// Logic to search possible moves
  bool considerPosition(String address) {
    return positions.considerPosition(address);
  }

// Logic to modify internal states
  bool movePiece(String nextPosition) {
    print('moving piece');
    final isUpdated = positions.movePiece(nextPosition);
    if (isUpdated) {
      _currentTurn = _currentTurn == 'white' ? 'black' : 'white';
    }
    _clearPositionConsideration();
    return isUpdated;
  }

  void _clearPositionConsideration() {
    positions.clearConsiderations();
    notifyListeners();
  }

  Piece? getPiece(String address) {
    return positions.getPiece(address);
  }

  bool isLegalMove(String address) {
    return positions.legalMoves.contains(address);
  }
}
