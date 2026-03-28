import 'package:flutter/material.dart';
import 'package:tictactoe_game/components/AppFont.dart';
import 'package:tictactoe_game/widgets/Background.dart';
import 'package:tictactoe_game/pages/vsPlayer.dart';
import 'package:tictactoe_game/pages/AILevels.dart';

class ChooseOpp extends StatelessWidget {
  const ChooseOpp({super.key});

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
                "Choose your opponent",
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VsPlayer()),
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
                        "vs Player",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AIlevels()),
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
                        "vs AI",
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
