import 'dart:math';

import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Helper {
  static String formatRupiah(double amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  AlertGetX(type, message) async {
    switch (type) {
      case "success":
        Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 35),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgcolorGreenAlert,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bgcirclecolorGreenAlert,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 70,
                    width: 70,
                    child: Icon(
                      Icons.verified_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            iconPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            titlePadding: EdgeInsets.only(top: 10, bottom: 2),
            contentPadding: EdgeInsets.only(bottom: 40, left: 10, right: 10),
            title: Text(
              'Berhasil',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
        await Future.delayed(Duration(seconds: 3), () {
          Get.back(); // Close the dialog
        });
        break;
      case "loading":
        Get.dialog(
          barrierDismissible: false,
          WillPopScope(
            onWillPop: () async => false, // Disable back button
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              icon: Container(
                padding: EdgeInsets.symmetric(vertical: 35),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3.0,
                      ),
                    ),
                  ],
                ),
              ),
              iconPadding: EdgeInsets.only(bottom: 0, top: 0),
              titlePadding: EdgeInsets.only(top: 10, bottom: 2),
              contentPadding: EdgeInsets.only(bottom: 40, left: 10, right: 10),
              title: Text(
                'Loading',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                "Mohon menunggu",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: textPrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );

        break;
      case "question":
        bool confirmed = false;
        await Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 35),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgcolorWaringAlert,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bgcircleWaringAlert,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 70,
                    width: 70,
                    child: Icon(
                      Icons.warning_rounded,
                      color: Colors.yellow[800],
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            iconPadding: EdgeInsets.only(bottom: 0, top: 0),
            titlePadding: EdgeInsets.only(top: 10, bottom: 2),
            contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
            title: Text(
              'Yakin?',
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              "Apakah kamu ingin melanjutkan?",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              GestureDetector(
                onTap: () {
                  confirmed = false;
                  Get.back(); // Close the dialog
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(),
                  child: Text(
                    'Tidak',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  backgroundColor: bgconfirmColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  confirmed = true;
                  Get.back(); // Close the dialog
                },
                child: Text(
                  'Ya',
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
        return confirmed;
      default:
        Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 35),
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgcolorRedAlert,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bgcircleRedAlert,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 70,
                    width: 70,
                    child: Icon(Icons.dangerous, color: Colors.white, size: 40),
                  ),
                ],
              ),
            ),
            iconPadding: EdgeInsets.only(bottom: 0, top: 0),
            titlePadding: EdgeInsets.only(top: 10, bottom: 2),
            contentPadding: EdgeInsets.only(bottom: 40, left: 10, right: 10),
            title: Text(
              'Gagal',
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: textPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
        Future.delayed(Duration(seconds: 3), () {
          Get.back(); // Close the dialog
        });
    }
  }

  void AlertSnackBar({String message = '', String status = 'error'}) {
    Color color;
    String sub_message;
    Icon icon;
    switch (status) {
      case 'success':
        icon = Icon(Icons.check, color: Colors.white);
        color = Colors.green;
        sub_message = 'Berhasil';
        break;
      case 'warning':
        icon = Icon(Icons.warning, color: Colors.white);
        color = Colors.yellow;
        sub_message = 'Peringatan';
        break;
      default:
        icon = Icon(Icons.error, color: Colors.white);
        sub_message = 'Silahkan hubungi cs';
        color = Colors.red;
    }

    Get.snackbar(
      "",
      "",
      backgroundColor: color,
      colorText: Colors.white,
      icon: icon,
      titleText: Text(
        message ?? 'Maaf, terjadi kesalahan',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Text(
        sub_message,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      margin: EdgeInsets.only(
        top: 10,
        left: defaultMargin,
        right: defaultMargin,
      ),
      duration: 2.seconds,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
    );
  }
}
