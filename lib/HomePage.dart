import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayX0 = ['', '', '', '', '', '', '', '', ''];

  bool xturn = true;
  static int xscore = 0;
  static int oscore = 0;
  int filledBoxes = 0;

  static var pressStart2pFont = TextStyle(
    fontFamily: "PressStart2P",
    color: Colors.deepOrange,
    letterSpacing: 3,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.black],
          ),
        ),
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
                  Text("TicTacToe Game", style: pressStart2pFont),
                  Text("MADE BY HAZEMWAEL", style: pressStart2pFont),
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
        filledBoxes += 1;
        xturn = !xturn;
      } else if (!xturn && displayX0[index] == '') {
        displayX0[index] = 'O';
        filledBoxes += 1;
        xturn = !xturn;
      }
      checkWinner();
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
        return Dialog(
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
                    backgroundColor: Colors.grey[900],
                    foregroundColor: Colors.deepOrange,
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
        );
      },
    );

    if (winner == 'O') {
      oscore += 1;
    } else if (winner == 'X') {
      xscore += 1;
    }
  }

  void showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
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
                    backgroundColor: Colors.grey[900],
                    foregroundColor: Colors.deepOrange,
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
        );
      },
    );
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayX0[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
