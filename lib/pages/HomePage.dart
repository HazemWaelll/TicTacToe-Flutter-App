import 'package:flutter/material.dart';
import 'package:tictactoe_game/components/AppFont.dart';
import 'package:tictactoe_game/widgets/Background.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:tictactoe_game/pages/ChooseOpp.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 120.0),
                  child: Text(
                    "Tic Tac Toe",
                    style: pressStart2pFont.copyWith(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: AvatarGlow(
                  duration: Duration(seconds: 2),
                  glowColor: const Color.fromARGB(255, 231, 151, 127),
                  repeat: true,
                  startDelay: Duration(milliseconds: 500),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    radius: 80.0,
                    child: ClipOval(
                      // ClipOval is used to make the image fit the CircleAvatar
                      child: Image.asset(
                        "assets/images/tictactoelogo.png",
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChooseOpp()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[900],
                          ),
                          child: Center(
                            child: Text(
                              'PLAY GAME',
                              style: pressStart2pFont.copyWith(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
