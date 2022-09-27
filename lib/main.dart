import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maplestory_app/boy.dart';
import 'package:maplestory_app/button.dart';
import 'package:maplestory_app/snail.dart';
import 'package:maplestory_app/teddy.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //BLUE SNAIL
  int snailSpriteCount = 0;
  double snailPosX = 0.5;
  String snailDirection = 'left';

  //TEDDY BEAK
  int teddySpriteCount = 0;
  double teddyPosX = 0;
  String teddyDirection = 'right';

  //BOY CHARACTER
  int boySpriteCount = 0;
  double boyPosX = -0.5;
  double boyPosY = 1;
  String boyDirection = 'left';
  int attackBoySpriteCount = 0;

  //LOADING SCREEN
  var loadingScreenColor = Colors.pink[300];
  var loadingScreenTextColor = Colors.blue[700];
  var tapToPlayColor = Colors.white;
  int loadingTime = 3;
  bool gameHasStarted = false;

  //CASH
  double cashPosX = 2;
  double cashPosY = 0.95;
  int cashSpriteStep = 1;

  //HEALTH MANA EXPERIENCE
  int currentExp = 80;
  int currentHP = 120;
  int currentMana = 100;
  double levelUpPosX = 5;
  double levelUpPosY = 5;

  bool underAttack = false;
  bool currentlyLeveling = false;

  //DAMAGE
  double damageY = 0.8;
  double damageX = 0.5 - 0.2; //SNAILPOSX
  var hitColor = Colors.transparent;

  //STAR
  double starX = 2;
  double starY = 2;
  int startSprite = 0;

  void playNow() {
    startGameTimer();
    moveSnail();
    moveTeddy();
    attack();
  }

  void startGameTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        loadingTime--;
      });
      if (loadingTime == 0) {
        setState(() {
          loadingScreenColor = Colors.transparent;

          loadingTime = 3;
          loadingScreenTextColor = Colors.transparent;
        });
        timer.cancel();
      }
    });
  }

  void attack() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        attackBoySpriteCount++;
      });

      if (attackBoySpriteCount == 4) {
        if (boyDirection == 'right' && boyPosX + 0.2 > snailPosX) {
          print('hit');
        } else {
          print('missed');
        }
        attackBoySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  void moveSnail() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      setState(() {
        snailSpriteCount++;

        if (snailDirection == 'left') {
          snailPosX -= 0.01;
        } else {
          snailPosX += 0.01;
        }

        if (snailPosX < 0.3) {
          snailDirection = 'right';
        } else if (snailPosX > 0.6) {
          snailDirection = 'left';
        }
        if (snailSpriteCount == 5) {
          snailSpriteCount = 0;
        }
      });
    });
  }

  void moveTeddy() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        teddySpriteCount++;

        if (teddySpriteCount == 24) {
          teddySpriteCount = 0;
        }
        if ((teddyPosX - boyPosX).abs() > 0.3) {
          if (boyDirection == 'right') {
            teddyPosX = boyPosX + 0.3;
          } else if (boyDirection == 'left') {
            teddyPosX = boyPosX - 0.3;
          }
        }

        if (teddyPosX - boyPosX > 0) {
          teddyDirection = 'left';
        } else {
          teddyDirection = 'right';
        }
      });
    });
  }

  void moveleft() {
    setState(() {
      boyPosX -= 0.03;
      boySpriteCount++;
      if (boySpriteCount == 14) {
        boySpriteCount = 0;
      }
      boyDirection = 'right';
    });
  }

  void moveRight() {
    setState(() {
      boyPosX += 0.03;
      boySpriteCount++;
      if (boySpriteCount == 14) {
        boySpriteCount = 0;
      }
      boyDirection = 'left';
    });
  }

  void jump() {
    double time = 0;
    double height = 0;
    double initialHeight = boyPosY;
    Timer.periodic(Duration(milliseconds: 70), (timer) {
      time += 0.05;
      height = -4.9 * time + 2.5 * time;

      setState(() {
        if (initialHeight - height > 1) {
          boyPosY = 1;
          timer.cancel();
          boySpriteCount = 1;
        } else {
          boyPosY = initialHeight - height;
          boySpriteCount = 2;
        }
      });
    });
  }

  void moveCash() {
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        cashSpriteStep++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey[900],
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment(snailPosX, 1),
                    child: BlueSnail(
                      snailSpriteCount: snailSpriteCount,
                      snailDirection: snailDirection,
                    ),
                  ),
                  Container(
                    alignment: Alignment(teddyPosX, 1),
                    child: MyTeddy(
                      teddyDirection: teddyDirection,
                      teddySpriteCount: teddySpriteCount,
                    ),
                  ),
                  Container(
                    alignment: Alignment(boyPosX, 1),
                    child: MyBoy(
                      attackBoySpriteCount: attackBoySpriteCount,
                      currentLeveling: currentlyLeveling,
                      underAttack: underAttack,
                      boyDirection: boyDirection,
                      boySpriteCount: boySpriteCount % 2 + 1,
                    ),
                  ),
                  Container(
                    color: loadingScreenColor,
                    child: Center(
                      child: Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Flutter ❤️ M A P L E S T O R Y',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: loadingScreenTextColor,
                                ),
                              ),
                              Text(
                                '$loadingTime',
                                style: TextStyle(
                                  color: loadingScreenTextColor,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.green[600],
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'M A P L E S T O R Y',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        text: 'PLAY',
                        function: () {
                          playNow();
                        },
                      ),
                      MyButton(
                        text: 'ATTACK',
                        function: () {
                          attack();
                        },
                      ),
                      MyButton(
                        text: '←',
                        function: () {
                          moveleft();
                        },
                      ),
                      MyButton(
                        text: '↑',
                        function: () {
                          jump();
                        },
                      ),
                      MyButton(
                        text: ' →',
                        function: () {
                          moveRight();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
