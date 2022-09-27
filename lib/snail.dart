import 'dart:math';

import 'package:flutter/material.dart';

class BlueSnail extends StatelessWidget {
  final int snailSpriteCount;
  final String snailDirection;
  BlueSnail({required this.snailSpriteCount, required this.snailDirection});

  @override
  Widget build(BuildContext context) {
    if (snailDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset(
          'assets/snail/snail$snailSpriteCount.png',
        ),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset('assets/snail/snail$snailSpriteCount.png'),
        ),
      );
    }
  }
}
