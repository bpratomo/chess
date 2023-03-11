import 'package:chess/models/piece.dart';
import 'package:chess/models/positions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Grid extends StatelessWidget {
  final Piece? piece;
  final String color;
  final String address;

  const Grid(this.piece, this.color, this.address, {super.key});
  void testCallback() {
    print('clicking on grid $address');
  }

  Color _getRenderedColor(position) {
    final defaultColor = color == 'dark' ? Colors.brown : Colors.white;
    final isHighlighted = position.legalMoves[address] ?? false;
    final renderedColor = isHighlighted ? Colors.teal : defaultColor;
    return renderedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Board>(builder: (context, position, child) {
      final renderedColor = _getRenderedColor(position);
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(), color: renderedColor),
          child: TextButton(
            onPressed: () => position.clickHandler(address),
            child: piece?.vectorIcon ?? const Text(''),
          ),
        ),
      );
    });
  }
}
