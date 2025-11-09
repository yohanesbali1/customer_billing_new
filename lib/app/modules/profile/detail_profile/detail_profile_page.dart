import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_profile_controller.dart';

class DetailProfilePage extends GetView<DetailProfileController> {
  const DetailProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final auth_c = Get.find<AuthController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        margin: const EdgeInsets.only(bottom: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: borderboxColor, width: 0.9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.9, color: borderboxColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Lengkap',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${auth_c.profile.value!.name}',
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.9, color: borderboxColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${auth_c.profile.value!.email}',
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.9, color: borderboxColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hp',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${auth_c.profile.value!.phone}',
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.9, color: borderboxColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alamat',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Html(
                          data: "${auth_c.profile.value!.address}",
                          style: {
                            "p": Style(
                              color: textPrimaryColor,
                              fontSize: FontSize(14),
                              fontWeight: FontWeight.w500,
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.9, color: borderboxColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Provinsi',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ' ${auth_c.profile.value!.province?.name ?? '-'}',
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.9, color: borderboxColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kabupaten',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ' ${auth_c.profile.value!.city?.name ?? '-'}',
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.9, color: borderboxColor),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kecamatan',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ' ${auth_c.profile.value!.subdistrict?.name ?? '-'}',
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Desa',
                          style: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ' ${auth_c.profile.value!.vilage ?? '-'}',
                          style: GoogleFonts.montserrat(
                            color: textPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
