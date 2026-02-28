import 'dart:math';

import 'package:vigo_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigo_billing/app/core/global_keys.dart';
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

  Future<dynamic> AlertGetX({type = "", message = ""}) async {
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

  void AlertSnackBar({
    BuildContext? context,
    String message = '',
    String status = 'error',
  }) {
    Color color;
    String subMessage;
    Widget iconWidget;
    switch (status) {
      case 'success':
        iconWidget = Icon(Icons.check, color: Colors.white);
        color = Colors.green;
        subMessage = 'Berhasil';
        break;
      case 'warning':
        iconWidget = Icon(Icons.warning, color: Colors.white);
        color = Colors.yellow;
        subMessage = 'Peringatan';
        break;
      default:
        iconWidget = Icon(Icons.error, color: Colors.white);
        if (message.isEmpty) message = 'Maaf, terjadi kesalahan';
        subMessage = 'Silahkan hubungi cs';
        color = Colors.red;
    }

    // Prefer using ScaffoldMessenger when a valid BuildContext is provided.
    if (context != null) {
      final messenger = ScaffoldMessenger.maybeOf(context);
      if (messenger != null) {
        messenger.showSnackBar(
          SnackBar(
            backgroundColor: color,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              top: 10,
              left: defaultMargin,
              right: defaultMargin,
            ),
            content: Row(
              children: [
                iconWidget,
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subMessage,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        return;
      }
    }

    // Try using global ScaffoldMessengerKey when no context-provided messenger.
    final globalMessenger = scaffoldMessengerKey.currentState;
    void showViaMessenger(ScaffoldMessengerState messenger) {
      messenger.showSnackBar(
        SnackBar(
          backgroundColor: color,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            top: 10,
            left: defaultMargin,
            right: defaultMargin,
          ),
          content: Row(
            children: [
              iconWidget,
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subMessage,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
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

    if (globalMessenger != null) {
      showViaMessenger(globalMessenger);
      return;
    }

    // Schedule a post-frame attempt to show the snackbar when the app is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messenger = scaffoldMessengerKey.currentState;
      if (messenger != null) {
        showViaMessenger(messenger);
      } else {
        debugPrint('No ScaffoldMessenger available to show snackbar');
      }
    });
  }

  int calculatePerPage(BuildContext context, {double itemHeight = 80}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final estimatedCount = (screenHeight / itemHeight).ceil();
    return estimatedCount + 2; // tambahkan buffer agar bisa scroll sedikit
  }
}
