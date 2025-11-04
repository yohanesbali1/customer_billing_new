import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintancePage extends StatelessWidget {
  const MaintancePage({super.key});
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset(
                'assets/icons/maintance.svg',
                height: 248,
                width: 240,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Whoops!',
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Masih dalam pengembangan',
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
