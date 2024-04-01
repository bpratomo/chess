import 'package:chess/models/movement/traversals.dart';
import 'package:chess/models/piece.dart';

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

class Positions {
  Positions() : positionToPieces = startingPosition;
  // Various position related utility functions
  final Map<String, Piece?> positionToPieces;

  Set<String> legalMoves = {};

  final List<(Piece, String)> moves = [];

  Piece? getPiece(String address) {
    return positionToPieces[address];
  }

  Piece getConsideredPiece() {
    return getPiece(considerationStartingPoint) ?? EmptyPiece();
  }

  bool pieceHasMoved(String id) {
    return moves.where((element) => element.$1.uuid == id).isNotEmpty;
  }

  String considerationStartingPoint = '';

  void clearConsiderations() {
    legalMoves.clear();
    considerationStartingPoint = '';
  }

  void _recordMove(Piece piece, String address) {
    moves.add((piece, address));
  }

  bool movePiece(String nextPosition) {
    print("Starting position $considerationStartingPoint");
    print("next position $nextPosition");

    if (!legalMoves.contains(nextPosition)) {
      clearConsiderations();
      return false;
    }

    Piece pieceBeingConsidered = getConsideredPiece();

    positionToPieces[considerationStartingPoint] = EmptyPiece();
    positionToPieces[nextPosition] = pieceBeingConsidered;
    _recordMove(pieceBeingConsidered, nextPosition);
    return true;
  }

  bool considerPosition(String address) {
    final pieceBeingConsidered = getPiece(address);
    if (pieceBeingConsidered == null) {
      return false;
    }

    considerationStartingPoint = address;
    legalMoves = Traversals.generateLegalMoves(address, this);

    return true;
  }
}
