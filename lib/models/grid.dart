import 'package:chess/models/piece.dart';
import 'package:chess/models/state/game_state.dart';
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

  Color _getRenderedColor(GameState state) {
    final defaultColor = color == 'dark' ? Colors.brown : Colors.white;
    final isHighlighted = state.isLegalMove(address);
    final renderedColor = isHighlighted ? Colors.teal : defaultColor;
    return renderedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(builder: (context, state, child) {
      final renderedColor = _getRenderedColor(state);
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(), color: renderedColor),
          child: TextButton(
            onPressed: () => state.clickHandler(address),
            child: piece?.vectorIcon ?? const Text(''),
          ),
        ),
      );
    });
  }
}
