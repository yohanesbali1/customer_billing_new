import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCardMember extends StatelessWidget {
  const SkeletonCardMember({super.key});
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardMemberClipPath(),
      child: Skeletonizer.zone(
        child: Container(
          width: 335,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF690305), Color(0xFFAC0205)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: bgColor, width: 0.5),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Bone.text(words: 2),
                          SizedBox(width: 10),
                          Bone.text(words: 2),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Bone.text(words: 2),
                                SizedBox(height: 5),
                                Bone.text(words: 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Bone.text(words: 2)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardMemberClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const fixedHeight = 160.0;

    Path path = Path();
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
