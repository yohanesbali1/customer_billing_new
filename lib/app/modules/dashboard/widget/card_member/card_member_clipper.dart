import 'package:flutter/material.dart';

class CardMemberClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const fixedHeight = 160.0;

    final path = Path();
    path.moveTo(8, 0);
    path.lineTo(size.width - 8, 0);
    path.cubicTo(size.width - 4, 0, size.width, 3.58, size.width, 8);
    path.lineTo(size.width, fixedHeight - 39.42);
    path.cubicTo(
      size.width,
      fixedHeight - 37.32,
      size.width - 0.82,
      fixedHeight - 35.31,
      size.width - 2.29,
      fixedHeight - 33.81,
    );
    path.lineTo(size.width - 33.18, fixedHeight - 2.39);
    path.cubicTo(
      size.width - 34.68,
      fixedHeight - 0.86,
      size.width - 36.74,
      fixedHeight,
      size.width - 38.88,
      fixedHeight,
    );
    path.lineTo(8, fixedHeight);
    path.cubicTo(3.58, fixedHeight, 0, fixedHeight - 3.58, 0, fixedHeight - 8);
    path.lineTo(0, 8);
    path.cubicTo(0, 3.58, 3.58, 0, 8, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
