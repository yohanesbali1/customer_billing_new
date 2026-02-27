import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPathPage extends GetView<RegisterController> {
  const RegisterPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Registrasi Akun',
          style: GoogleFonts.montserrat(
            color: Color(0xFF0F1B26),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 46),
              height: 154,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/photo.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Verifikasi Identitas Diri',
                style: GoogleFonts.montserrat(
                  color: textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'Untuk kemudahan dalam pemasangan wifi dan keamanan, mohon lakukan verifikasi data diri. Tenang saja, kami menjamin kerahasian data anda',
                style: GoogleFonts.montserrat(
                  color: textSecondaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: borderboxColor),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Text(
                                'Dokumen resmi',
                                style: GoogleFonts.montserrat(
                                  color: textPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'e-KTP, KTP, SIM atau NIK',
                                style: GoogleFonts.montserrat(
                                  color: textSecondaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Upload',
                        style: GoogleFonts.montserrat(
                          color: mainColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: borderboxColor),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Text(
                                'Foto rumah',
                                style: GoogleFonts.montserrat(
                                  color: textPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Max 1mb, JPG/PNG, multi image',
                                style: GoogleFonts.montserrat(
                                  color: textSecondaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Upload',
                        style: GoogleFonts.montserrat(
                          color: mainColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgsecondColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'BATAL',
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'SiMPAN',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/register/alert');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
