import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';

class GuideData extends StatelessWidget {
  final controller;
  const GuideData({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tata Cara Pembayaran',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: borderboxColor, // Set the border color
              width: 0.5, // Set the border width
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Html(data: "${controller.bank_data.value?.guide}")],
          ),
        ),
      ],
    );
  }
}
