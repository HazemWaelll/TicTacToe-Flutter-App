import 'package:flutter/material.dart';
import 'package:tictactoe_game/components/AppFont.dart';
import 'package:tictactoe_game/pages/VsAI.dart';
import 'package:tictactoe_game/widgets/Background.dart';

class AIlevels extends StatelessWidget {
  const AIlevels({super.key});

  // ignore: non_constant_identifier_names
  static int? AIlevel;

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Text(
                "Choose",
                style: pressStart2pFont.copyWith(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 175),
              child: Text(
                "AI level",
                style: pressStart2pFont.copyWith(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                GestureDetector(
                  onTap: () {
                    AIlevel = 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VsAI()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[850],
                    ),
                    child: Center(
                      child: Text(
                        "Easy",
                        style: pressStart2pFont.copyWith(
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    AIlevel = 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VsAI()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[850],
                    ),
                    child: Center(
                      child: Text(
                        "Medium",
                        style: pressStart2pFont.copyWith(
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    AIlevel = 2;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VsAI()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[850],
                    ),
                    child: Center(
                      child: Text(
                        "Hard",
                        style: pressStart2pFont.copyWith(
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
