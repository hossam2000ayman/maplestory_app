import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  final int boySpriteCount;
  final String boyDirection;
  int attackBoySpriteCount;
  final bool underAttack;
  final bool currentLeveling;

  MyBoy({
    required this.boyDirection,
    required this.boySpriteCount,
    required this.attackBoySpriteCount,
    required this.underAttack,
    required this.currentLeveling,
  });

  @override
  Widget build(BuildContext context) {
    int directionAsInt = 1;

    if (boyDirection == 'right') {
      directionAsInt = 1;
    } else if (boyDirection == 'left') {
      directionAsInt = 0;
    } else {
      directionAsInt = 1;
    }

    if (attackBoySpriteCount == 1) {
      return Container(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(pi * directionAsInt),
          child: Image.asset(
              'assets/fighter/fightersuper$attackBoySpriteCount.png'),
        ),
      );
    }

    if (boyDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 100,
        width: 100,
        child: Image.asset('assets/fighter/fighter$boySpriteCount.png'),
      );
    } else {
      return Transform(
        transform: Matrix4.rotationY(pi),
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 100,
          width: 100,
          child: Image.asset('assets/fighter/fighter$boySpriteCount.png'),
        ),
      );
    }
  }
}
