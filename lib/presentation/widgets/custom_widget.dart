import 'package:flutter/material.dart';

Widget circleHoverButton(Widget child) {
  return Container(
    width: 30,
    height: 30,
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.all(1),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // start transparent
    ),
    child: child,
  );
}