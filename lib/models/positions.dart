import 'dart:collection';

import 'package:chess/models/piece.dart';
import 'package:flutter/material.dart';
import 'package:chess/models/traversals.dart';

class Positions extends ChangeNotifier {
  Positions() : _positionToPieces = startingPosition;

  Map<String, Piece?> _positionToPieces;

  UnmodifiableMapView<String, Piece?> get positionToPieces =>
      UnmodifiableMapView(_positionToPieces);
  void movePiece(String movement) {
    final previousPosition = movement.substring(0, 2);
    final targetPosition = movement.substring(2);
    final piece = positionToPieces[previousPosition];
    _positionToPieces[previousPosition] = null;
    _positionToPieces[targetPosition] = piece;
    _positionToHighlights = {};
    notifyListeners();
  }

  String _positionBeingConsidered = '';
  Map<String, bool> _positionToHighlights = {};
  UnmodifiableMapView<String, bool> get positionToHighlights =>
      UnmodifiableMapView(_positionToHighlights);

  void considerPosition(String address, Piece piece) {
    _positionToHighlights =
        Traversals.generatePathways(address, piece, positionToPieces);
    notifyListeners();
  }

  void clickHandler(String address) {
    final piece = positionToPieces[address];

    final isAddressEmpty = piece == null;

    // Check if we're currently considering any position
    if (_positionBeingConsidered == '' && isAddressEmpty) {
      return;
    }

    if (_positionBeingConsidered == '' && !isAddressEmpty) {
      considerPosition(address, piece);
    }

    final isLegalMove = positionToHighlights[address] != null;
    if (_positionBeingConsidered != '' && isLegalMove) {
      movePiece('$_positionBeingConsidered$address');
    }

    if (_positionBeingConsidered != '' && !isLegalMove) {
      _positionBeingConsidered = '';
      _positionToHighlights = {};
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
