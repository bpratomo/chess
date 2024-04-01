import 'package:chess/models/grid.dart';
import 'package:chess/models/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardRenderer extends StatelessWidget {
  const BoardRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
        builder: (context, positions, child) => renderBoard(positions),
        child: const Text('building board...'));
  }
}

Widget renderBoard(GameState state) {
  const horizontal = 'abcdefgh';
  const vertical = '87654321';
  var rowStartingColor = 'light';
  var rowList = <Widget>[];
  List<Grid> gridList;

// Each loop here adds a row to construct a full board
  for (final number in vertical.split('')) {
    var color = rowStartingColor;
    gridList = [];

// Each loop adds a grid to construct a full row
    for (final letter in horizontal.split('')) {
      final address = '$letter$number';
      final piece = state.getPiece(address);

      gridList.add(Grid(piece, color, address));

      color = color == 'dark' ? 'light' : 'dark';
    }

    final row = Expanded(
      child: Row(children: gridList),
    );

    rowList.add(row);
    rowStartingColor = rowStartingColor == 'dark' ? 'light' : 'dark';
  }

  return AspectRatio(
    aspectRatio: 1 / 1,
    child: Column(children: rowList),
  );
}
