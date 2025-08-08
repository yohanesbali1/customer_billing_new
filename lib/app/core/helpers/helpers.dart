import 'dart:math';

import 'package:customer_billing/app/core/theme/theme.dart';
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

  void AlertSnackBar(dynamic status) {
    switch (status) {
      default:
        Get.snackbar(
          "",
          "",
          backgroundColor: redColor,
          colorText: Colors.white,
          icon: Icon(Icons.error, color: Colors.white),
          titleText: Text(
            'Maaf, terjadi kesalahan',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          messageText: Text(
            'Silahkan hubungi cs',
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

  // OverlayEntry? show_loading(context) {
  //   final overlay = Overlay.of(context);
  //   if (overlay == null) {
  //     throw FlutterError('No overlay found in the current context');
  //   }
  //   final overlayEntry = OverlayEntry(
  //     builder: (context) => Material(
  //       color: Colors.transparent.withOpacity(
  //           0.5), // Ensures no material shadows or effects interfere.
  //       child: Container(
  //         width: double.infinity,
  //         height: double.infinity,
  //         // color: Colors.white.withOpacity(0.7), // Semi-transparent overlay.
  //         child: Center(
  //           child: Container(
  //             height: 270, // Increased height for better spacing.
  //             width: 280, // Adjusted width for a better layout.
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Column(
  //               mainAxisAlignment:
  //                   MainAxisAlignment.start, // Center column items vertically.
  //               children: [
  //                 Container(
  //                     width: double.infinity,
  //                     height: 150,
  //                     decoration: BoxDecoration(
  //                         color: mainColor,
  //                         borderRadius: const BorderRadius.only(
  //                             topLeft: Radius.circular(20),
  //                             topRight: Radius.circular(20))),
  //                     child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Container(
  //                             height: 40,
  //                             width: 40,
  //                             child: CircularProgressIndicator(
  //                               color: Colors.white,
  //                               strokeWidth: 3.0,
  //                             ),
  //                           )
  //                         ])),

  //                 SizedBox(
  //                     height:
  //                         21), // Adds spacing between the progress indicator and text.
  //                 Text(
  //                   'Loading',
  //                   style: GoogleFonts.montserrat(
  //                     color: textPrimaryColor,
  //                     fontSize: 22,
  //                     fontWeight: FontWeight.w400,
  //                     decoration: TextDecoration.none,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                     height:
  //                         5), // Adds spacing between the progress indicator and text.
  //                 Text(
  //                   'Mohon tunggu',
  //                   style: GoogleFonts.montserrat(
  //                     color: textPrimaryColor,
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w400,
  //                     decoration: TextDecoration.none,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //   overlay.insert(overlayEntry);
  //   return overlayEntry;
  // }

  // void custom_alert(context) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Stack(
  //         clipBehavior: Clip.none,
  //         children: [
  //           Container(
  //             padding: EdgeInsets.all(16),
  //             height: 90,
  //             decoration: BoxDecoration(
  //                 color: Color(0xFFC72C41),
  //                 borderRadius: BorderRadius.all(Radius.circular(20))),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 const SizedBox(
  //                   width: 48,
  //                 ),
  //                 const Text("test"),
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //               bottom: 0,
  //               child: ClipRRect(
  //                 borderRadius:
  //                     BorderRadius.only(bottomLeft: Radius.circular(20)),
  //                 child: SvgPicture.asset(
  //                   'assets/icons/bubbles.svg',
  //                   height: 48,
  //                   width: 40,
  //                   color: Color(0xFF801336),
  //                 ),
  //               )),
  //           Positioned(
  //               top: -20,
  //               left: 0,
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 children: [
  //                   SvgPicture.asset(
  //                     'assets/icons/fail.svg',
  //                     height: 40,
  //                   ),
  //                   Positioned(
  //                     top: 10,
  //                     child: SvgPicture.asset(
  //                       'assets/icons/close.svg',
  //                       height: 16,
  //                     ),
  //                   ),
  //                 ],
  //               ))
  //         ],
  //       ),
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //       duration: Duration(seconds: 3),
  //       dismissDirection: DismissDirection.none,
  //       padding: EdgeInsets.symmetric(vertical: 20)));
  // }

  // Alert(dynamic status, String? message, BuildContext context) async {
  //   switch (status) {
  //     case 'success':
  //       await QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.success,
  //         showConfirmBtn: false,
  //         title: "Berhasil",
  //         barrierDismissible: false,
  //         autoCloseDuration: Duration(seconds: 4),
  //         text: 'Data berhasil di simpan',
  //       );
  //       break;
  //     case 'loading':
  //       await QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.loading,
  //         title: 'Loading',
  //         text: 'Mohon menuggu',
  //       );
  //       break;
  //     case 'question':
  //       bool confirmed = false;
  //       await QuickAlert.show(
  //         context: context,
  //         type: QuickAlertType.warning,
  //         title: 'Yakin?',
  //         text: 'Apakah kamu ingin melanjutkan?',
  //         confirmBtnText: 'Ya',
  //         cancelBtnText: 'Tidak',
  //         showCancelBtn: true,
  //         onConfirmBtnTap: () {
  //           confirmed = true;
  //           Navigator.of(context, rootNavigator: true).pop();
  //         },
  //         onCancelBtnTap: () {
  //           confirmed = false;
  //           Navigator.of(context, rootNavigator: true).pop();
  //         },
  //       );
  //       return confirmed;
  //     default:
  //       await QuickAlert.show(
  //         context: context,
  //         barrierDismissible: false,
  //         type: QuickAlertType.error,
  //         showConfirmBtn: false,
  //         title: "Gagal",
  //         text: message,
  //         autoCloseDuration: Duration(seconds: 4),
  //       );
  //   }
  // }
}
