import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/about/about_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Kembali',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(maxWidth: 209, maxHeight: 102),
              child: Image.asset('assets/images/logo-icon.png'),
            ),
            const SizedBox(height: 20),
            Container(
              child: Text(
                '''
WNG merupakan salah satu brand penjualan utama dari PT. Wisuandha Network Globalindo, dimana kami merupakan sebuah perusahaan yang bergerak dalam bidang penyedia Jasa Layanan Internet (Internet Service Provider). Perusahaan kami berdiri pada tahun 2013. Pada awalnya kami merupakan Reseller dari salah satu Perusahaan Internet terkemuka di Indonesia.

Dengan berjalannya waktu dan dengan komitmen kuat dalam mengutamakan layanan kepada pihak Konsumen, sehingga pada tahun 2019 kami mampu bertranformasi menjadi Sebuah Perusahaan Layanan Jasa Internet yang berdiri di kaki sendiri, dan telah memperoleh Ijin Penyelenggara dari KOMINFO dengan nomor 10/TEL.02.02/2019 dan kami juga telah mengantongi Ijin Jaringan Tetap Lokal dari KOMINFO dengan nomor 61/TEL.01.02/2019. Dalam organisasi, kami juga telah terdaftar di Asosiasi Penyelenggara Internet Indonesia dengan nomor anggota 0629/APJII/K-2021.''',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: textPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
