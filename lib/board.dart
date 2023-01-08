import 'package:chess/models/grid.dart';
import 'package:chess/models/positions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Board extends StatelessWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Positions>(
        builder: (context, positions, child) => buildBoard(positions),
        child: const Text('building board...'));
  }
}

Widget buildBoard(Positions pos) {
  const horizontal = 'abcdefgh';
  const vertical = '87654321';
  var startingColor = 'light';
  var rowList = <Widget>[];
  List<Grid> gridList;

  for (final number in vertical.split('')) {
    var color = startingColor;
    gridList = [];
    for (final letter in horizontal.split('')) {
      final address = '$letter$number';
      final piece = pos.positionToPieces[address];

      gridList.add(Grid(piece, color, address));

      color = color == 'dark' ? 'light' : 'dark';
    }
    final row = Expanded(
      child: Row(children: gridList),
    );
    rowList.add(row);
    startingColor = startingColor == 'dark' ? 'light' : 'dark';
  }

  return AspectRatio(
    aspectRatio: 1 / 1,
    child: Column(children: rowList),
  );
}
