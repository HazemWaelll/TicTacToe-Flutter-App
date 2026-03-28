import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tictactoe_game/components/AppFont.dart';
import 'package:tictactoe_game/widgets/Background.dart';
import 'package:tictactoe_game/pages/AILevels.dart';

class VsAI extends StatefulWidget {
  const VsAI({super.key});

  @override
  State<VsAI> createState() => _VsAIState();
}

class _VsAIState extends State<VsAI> {
  List<String> displayX0 = ['', '', '', '', '', '', '', '', ''];
  final List<int> moveHistory = []; // Used to save indexes of last moves

  static const List<List<int>> winLines = <List<int>>[
    <int>[0, 1, 2],
    <int>[3, 4, 5],
    <int>[6, 7, 8],
    <int>[0, 3, 6],
    <int>[1, 4, 7],
    <int>[2, 5, 8],
    <int>[0, 4, 8],
    <int>[2, 4, 6],
  ];

  bool roundOver = false;

  bool playerTurn = true;
  bool roundStartsWithX = true;
  int playerScore = 0;
  int aiScore = 0;
  int filledBoxes = 0;
  String streakPlayer = '';
  int streakCount = 0;
  final level = AIlevels.AIlevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          children: [
            SizedBox(height: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // X Score
                        Text("Player", style: pressStart2pFont),
                        SizedBox(height: 20),
                        Text(playerScore.toString(), style: pressStart2pFont),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // O Score
                        Text("AI", style: pressStart2pFont),
                        SizedBox(height: 20),
                        Text(aiScore.toString(), style: pressStart2pFont),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              playerTurn ? "Player Turn" : "AI Turn",
              style: pressStart2pFont,
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                physics:
                    NeverScrollableScrollPhysics(), // Make the grid to be fixed in position
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Center(
                        child: Text(
                          displayX0[index],
                          style: pressStart2pFont.copyWith(fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    streakCount == 0
                        ? 'Win Streak: None'
                        : 'Win Streak: Player $streakPlayer x$streakCount',
                    style: pressStart2pFont.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Moves: $filledBoxes/9',
                    style: pressStart2pFont.copyWith(fontSize: 10),
                  ),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: clearBoard,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[850],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('New Round', style: pressStart2pFont),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      GestureDetector(
                        onTap: undoMove,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[850],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Undo', style: pressStart2pFont),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (playerTurn && displayX0[index] == '') {
        displayX0[index] = 'X';
        moveHistory.add(index);
        filledBoxes += 1;
        playerTurn = !playerTurn;
      }
      if (!playerTurn && !roundOver) {
        Future.delayed(const Duration(milliseconds: 300), () {
          aiTapped();
        });
      }
      checkWinner();
    });
  }

  void aiTapped() {
    if (level == 0) {
      aiEasy();
    } else if (level == 1) {
      aiMedium();
    } else if (level == 2) {
      aiHard();
    }
  }

  // Easy level
  void aiEasy() {
    if (roundOver) return;
    if (filledBoxes >= 9) return;

    final List<int> empty = emptyIndexes(displayX0);
    if (empty.isEmpty) return;

    final int chosenIndex = empty[Random().nextInt(empty.length)];
    aiMove(chosenIndex);
  }

  // Medium level
  void aiMedium() {
    if (roundOver) return;
    if (filledBoxes >= 9) return;

    // 1) If can win, do it
    final int? winMove = findWinningMove(displayX0, 'O');
    if (winMove != null) {
      aiMove(winMove);
      return;
    }

    // 2) Block the player if they can win
    final int? blockMove = findWinningMove(displayX0, 'X');
    if (blockMove != null) {
      aiMove(blockMove);
      return;
    }

    // 3) Sometimes take the center, otherwise play random
    final List<int> empty = emptyIndexes(displayX0);
    if (empty.isEmpty) return;

    final bool center = displayX0[4].isEmpty && Random().nextBool();
    if (center) {
      aiMove(4);
      return;
    }

    // 4) Random move
    aiMove(empty[Random().nextInt(empty.length)]);
  }

  // Hard level
  void aiHard() {
    if (roundOver) return;
    if (filledBoxes >= 9) return;

    // 1) If can win, do it
    final int? winMove = findWinningMove(displayX0, 'O');
    if (winMove != null) {
      aiMove(winMove);
      return;
    }

    // 2) Block the player if they can win
    final int? blockMove = findWinningMove(displayX0, 'X');
    if (blockMove != null) {
      aiMove(blockMove);
      return;
    }

    // 3) Prefer center
    if (displayX0[4].isEmpty) {
      aiMove(4);
      return;
    }

    // 4) Prefer a random corner
    final List<int> emptyCorners = <int>[];
    for (final int i in [0, 2, 6, 8]) {
      if (displayX0[i].isEmpty) emptyCorners.add(i);
    }
    if (emptyCorners.isNotEmpty) {
      aiMove(emptyCorners[Random().nextInt(emptyCorners.length)]);
      return;
    }

    // 5) Pick any random empty cell
    final List<int> empty = emptyIndexes(displayX0);
    if (empty.isEmpty) return;
    aiMove(empty[Random().nextInt(empty.length)]);
  }

  void aiMove(int index) {
    setState(() {
      displayX0[index] = 'O';
      moveHistory.add(index);
      filledBoxes += 1;
      playerTurn = !playerTurn;
      checkWinner();
    });
  }

  List<int> emptyIndexes(List<String> board) {
    final List<int> empty = <int>[];
    for (int i = 0; i < board.length; i++) {
      if (board[i].isEmpty) empty.add(i);
    }
    return empty;
  }

  int? findWinningMove(List<String> board, String symbol) {
    for (final List<int> line in winLines) {
      int symbolCount = 0;
      int emptyCount = 0;
      int emptyIndex = -1;

      for (final int i in line) {
        if (board[i] == symbol) {
          symbolCount += 1;
        } else if (board[i].isEmpty) {
          emptyCount += 1;
          emptyIndex = i;
        }
      }

      if (symbolCount == 2 && emptyCount == 1) {
        return emptyIndex;
      }
    }

    return null;
  }

  void undoMove() {
    if (moveHistory.isEmpty) {
      return;
    }
    setState(() {
      final int lastIndex = moveHistory
          .removeLast(); // returns the last element of the list
      final String lastValue = displayX0[lastIndex];
      displayX0[lastIndex] = '';
      filledBoxes -= 1;
      playerTurn = lastValue == 'X';
    });
  }

  void checkWinner() {
    // checks 1st row
    if (displayX0[0] == displayX0[1] &&
        displayX0[0] == displayX0[2] &&
        displayX0[0] != '') {
      return showWinDialog(displayX0[0]);
    }

    // checks 2nd row
    if (displayX0[3] == displayX0[4] &&
        displayX0[3] == displayX0[5] &&
        displayX0[3] != '') {
      return showWinDialog(displayX0[3]);
    }

    // checks 3rd row
    if (displayX0[6] == displayX0[7] &&
        displayX0[6] == displayX0[8] &&
        displayX0[6] != '') {
      return showWinDialog(displayX0[6]);
    }

    // checks 1st column
    if (displayX0[0] == displayX0[3] &&
        displayX0[0] == displayX0[6] &&
        displayX0[0] != '') {
      return showWinDialog(displayX0[0]);
    }

    // checks 2nd column
    if (displayX0[1] == displayX0[4] &&
        displayX0[1] == displayX0[7] &&
        displayX0[1] != '') {
      return showWinDialog(displayX0[1]);
    }

    // checks 3rd column
    if (displayX0[2] == displayX0[5] &&
        displayX0[2] == displayX0[8] &&
        displayX0[2] != '') {
      return showWinDialog(displayX0[2]);
    }

    // checks diagonal
    if (displayX0[0] == displayX0[4] &&
        displayX0[0] == displayX0[8] &&
        displayX0[0] != '') {
      return showWinDialog(displayX0[0]);
    }

    // checks anti diagonal
    if (displayX0[2] == displayX0[4] &&
        displayX0[2] == displayX0[6] &&
        displayX0[2] != '') {
      return showWinDialog(displayX0[2]);
    } else if (filledBoxes == 9) {
      return showDrawDialog();
    }
  }

  void showWinDialog(String winner) {
    roundOver = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 58, 26, 112),
                    const Color.fromARGB(255, 142, 19, 60),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    winner == 'X' ? 'Player won!' : 'AI won!',
                    style: pressStart2pFont.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                    ),
                    child: Text('Play Again!', style: pressStart2pFont),
                    onPressed: () {
                      clearBoard();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (winner == 'O') {
      aiScore += 1;
    } else if (winner == 'X') {
      playerScore += 1;
    }

    // Winner is remain the first turn in the next round
    roundStartsWithX = winner == 'X';

    if (streakPlayer == winner) {
      streakCount += 1;
    } else {
      streakPlayer = winner;
      streakCount = 1;
    }
  }

  void showDrawDialog() {
    roundOver = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 58, 26, 112),
                    const Color.fromARGB(255, 142, 19, 60),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Draw',
                    style: pressStart2pFont.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                    ),
                    child: Text('Play Again!', style: pressStart2pFont),
                    onPressed: () {
                      clearBoard();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    streakPlayer = '';
    streakCount = 0;
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayX0[i] = '';
      }
      moveHistory.clear();
      filledBoxes = 0;
      playerTurn = roundStartsWithX;
      roundOver = false;
    });

    if (!playerTurn && !roundOver) {
      Future.delayed(const Duration(milliseconds: 250), () {
        aiTapped();
      });
    }
  }
}
