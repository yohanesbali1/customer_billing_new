import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundCardMember extends StatelessWidget {
  const NotFoundCardMember({super.key});
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardMemberClipPath(),
      child: Container(
          width: 335,
          height: 170,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEF8200),
                Color(0xFF212360),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // decoration: BoxDecoration(
                //     border:
                //         Border(bottom: BorderSide(color: bgColor, width: 0.5))),

                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ClipRRect(
                      //   borderRadius:
                      //       BorderRadius.only(bottomLeft: Radius.circular(20)),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/not-found.svg',
                      //     height: 78,
                      //     width: 70,
                      //   ),
                      // ),
                      Text(
                        'Whoops!',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Paket tidak ditemukan',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // Container(
                      //     child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [],
                      // )),
                      // Container(
                      //     margin: EdgeInsets.only(top: 14),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [],
                      //           ),
                      //         ),
                      //       ],
                      //     ))
                    ]),
              ),
            ],
          )),
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
    path.cubicTo(size.width, fixedHeight - 37.32, size.width - 0.82,
        fixedHeight - 35.31, size.width - 2.29, fixedHeight - 33.81);
    path.lineTo(size.width - 33.18, fixedHeight - 2.39);
    path.cubicTo(size.width - 34.68, fixedHeight - 0.86, size.width - 36.74,
        fixedHeight, size.width - 38.88, fixedHeight);
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
