import 'package:flutter/material.dart';
import 'package:tictactoe_game/widgets/Background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayX0 = ['', '', '', '', '', '', '', '', ''];
  final List<int> moveHistory = []; // Used to save indexes of last moves

  static bool xturn = true;
  static bool roundStartsWithX = true;
  static int xscore = 0;
  static int oscore = 0;
  int filledBoxes = 0;
  static String streakPlayer = '';
  static int streakCount = 0;

  static var pressStart2pFont = TextStyle(
    fontFamily: "PressStart2P",
    color: Colors.deepOrange,
    letterSpacing: 3,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          children: [
            SizedBox(height: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // X Score
                        Text("Player X", style: pressStart2pFont),
                        SizedBox(height: 20),
                        Text(xscore.toString(), style: pressStart2pFont),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // O Score
                        Text("Player O", style: pressStart2pFont),
                        SizedBox(height: 20),
                        Text(oscore.toString(), style: pressStart2pFont),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              xturn ? "Player X Turn" : "Player O Turn",
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
      if (xturn && displayX0[index] == '') {
        displayX0[index] = 'X';
        moveHistory.add(index);
        filledBoxes += 1;
        xturn = !xturn;
      } else if (!xturn && displayX0[index] == '') {
        displayX0[index] = 'O';
        moveHistory.add(index);
        filledBoxes += 1;
        xturn = !xturn;
      }
      checkWinner();
    });
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
      xturn = lastValue == 'X';
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
                    'Winner is: $winner',
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
      oscore += 1;
    } else if (winner == 'X') {
      xscore += 1;
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
      xturn = roundStartsWithX;
    });
  }
}
