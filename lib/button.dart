import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final function;

  MyButton({required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            color: Colors.grey[700],
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
