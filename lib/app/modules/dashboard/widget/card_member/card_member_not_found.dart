import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'card_member_clipper.dart';

class NotFoundCardMember extends StatelessWidget {
  const NotFoundCardMember({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardMemberClipPath(),
      child: Container(
        width: 335,
        height: 170,
        decoration: const BoxDecoration(gradient: kRedGradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
