import 'dart:math';

import 'package:flutter/material.dart';

class MyTeddy extends StatelessWidget {
  final int teddySpriteCount;
  final String teddyDirection;
  MyTeddy({required this.teddyDirection, required this.teddySpriteCount});

  @override
  Widget build(BuildContext context) {
    if (teddyDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset('assets/teddy/teddy$teddySpriteCount.png'),
      );
    } else {
      return Transform(
        transform: Matrix4.rotationY(pi),
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset('assets/teddy/teddy$teddySpriteCount.png'),
        ),
      );
    }
  }
}
