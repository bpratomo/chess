import 'dart:collection';

import 'package:chess/models/piece.dart';
import 'package:flutter/material.dart';
import 'package:chess/models/movement/traversals.dart';

class Board extends ChangeNotifier {
  Board() : _positionToPieces = startingPosition;

  // Various position related utility functions
  final Map<String, Piece?> _positionToPieces;

  UnmodifiableMapView<String, Piece?> get positionToPieces =>
      UnmodifiableMapView(_positionToPieces);

  Map<String, bool> _legalMoves = {};

  UnmodifiableMapView<String, bool> get legalMoves =>
      UnmodifiableMapView(_legalMoves);

  String _positionBeingConsidered = '';
  bool get isAPositionBeingConsidered => _positionBeingConsidered != '';

// Logic to search possible moves
  void considerPosition(String address, Piece piece) {
    _positionBeingConsidered = address;
    _legalMoves =
        Traversals.generateLegalMoves(address, piece, positionToPieces);
    notifyListeners();
  }

// Logic to modify internal states
  void movePiece(String movement) {
    final previousPosition = movement.substring(0, 2);
    final targetPosition = movement.substring(2);
    final piece = positionToPieces[previousPosition];
    _positionToPieces[previousPosition] = EmptyPiece();
    _positionToPieces[targetPosition] = piece;
    _legalMoves = {};
    notifyListeners();
  }

// Entry point of user interaction
  void clickHandler(String address) {
    final piece = positionToPieces[address];
    final isAddressEmpty = piece == null;

    // Initial state: no position is clicked yet
    // Case 1: clicking on empty board
    if (!isAPositionBeingConsidered && isAddressEmpty) {
      return;
    }

    // Case 2: clicking on a filled board
    if (!isAPositionBeingConsidered && !isAddressEmpty) {
      considerPosition(address, piece);
      return;
    }

    // Intermediary state: a position is already clicked
    final isLegalMove = legalMoves[address] != null;

    // Case 1: move is legal
    if (isAPositionBeingConsidered && isLegalMove) {
      movePiece('$_positionBeingConsidered$address');
      return;
    }

    // Case 2: move is illegal
    if (isAPositionBeingConsidered && !isLegalMove) {
      _positionBeingConsidered = '';
      _legalMoves = {};

      return;
    }
  }
}

final startingPosition = {
  'a8': Piece('rook', 'black'),
  'b8': Piece('knight', 'black'),
  'c8': Piece('bishop', 'black'),
  'd8': Piece('queen', 'black'),
  'e8': Piece('king', 'black'),
  'f8': Piece('bishop', 'black'),
  'g8': Piece('knight', 'black'),
  'h8': Piece('rook', 'black'),
  'a7': Piece('pawn', 'black'),
  'b7': Piece('pawn', 'black'),
  'c7': Piece('pawn', 'black'),
  'd7': Piece('pawn', 'black'),
  'e7': Piece('pawn', 'black'),
  'f7': Piece('pawn', 'black'),
  'g7': Piece('pawn', 'black'),
  'h7': Piece('pawn', 'black'),
  'a1': Piece('rook', 'white'),
  'b1': Piece('knight', 'white'),
  'c1': Piece('bishop', 'white'),
  'd1': Piece('queen', 'white'),
  'e1': Piece('king', 'white'),
  'f1': Piece('bishop', 'white'),
  'g1': Piece('knight', 'white'),
  'h1': Piece('rook', 'white'),
  'a2': Piece('pawn', 'white'),
  'b2': Piece('pawn', 'white'),
  'c2': Piece('pawn', 'white'),
  'd2': Piece('pawn', 'white'),
  'e2': Piece('pawn', 'white'),
  'f2': Piece('pawn', 'white'),
  'g2': Piece('pawn', 'white'),
  'h2': Piece('pawn', 'white'),
};
