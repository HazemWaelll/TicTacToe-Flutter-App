import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
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
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[850],
                          ),
                          child: Center(
                            child: Text(
                              'PLAY GAME',
                              style: pressStart2pFont.copyWith(
                                color: Colors.deepOrange,
                              ),
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
