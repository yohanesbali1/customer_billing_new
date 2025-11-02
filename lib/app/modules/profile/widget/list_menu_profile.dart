import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/modules/auth/controller/auth_controller.dart';
import 'package:customer_billing/app/modules/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final auth_c = Get.put(AuthController());

class ListMenuProfile extends StatelessWidget {
  final ProfileController controller;
  const ListMenuProfile({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/profile/detail');
          },
          child: Container(
            // color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Colors.grey.shade300, width: 1.0),
                right: BorderSide(color: Colors.grey.shade300, width: 1.0),
                top: BorderSide(color: Colors.grey.shade300, width: 1.0),
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon(
                    //   Icons.logout,
                    //   color: Colors.red,
                    // ),
                    Text(
                      'Data Profil',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 8),
          child: Text(
            'Info Aplikasi',
            textAlign: TextAlign.start,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/about/app');
          },
          child: Container(
            // color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Colors.grey.shade300, width: 1.0),
                right: BorderSide(color: Colors.grey.shade300, width: 1.0),
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
                top: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon(
                    //   Icons.logout,
                    //   color: Colors.red,
                    // ),
                    Text(
                      'Tentang Kami',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 8),
          child: Text(
            'Akun',
            textAlign: TextAlign.start,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/profile/update-password');
          },
          child: Container(
            // color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Colors.grey.shade300, width: 1.0),
                right: BorderSide(color: Colors.grey.shade300, width: 1.0),
                top: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon(
                    //   Icons.logout,
                    //   color: Colors.red,
                    // ),
                    Text(
                      'Ubah Password',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: () async {
        //     QuickAlert.show(
        //       context: context,
        //       type: QuickAlertType.warning,
        //       showConfirmBtn: true,
        //       showCancelBtn: true,
        //       barrierDismissible: false,
        //       title: "Peringatan",
        //       text:
        //           'Menghapus akun ini akan memberhentikan langganan yang sudah berjalan. Apakah anda yakin ? ',
        //       cancelBtnText: 'Batal',
        //       cancelBtnTextStyle: GoogleFonts.montserrat(
        //           fontSize: 13,
        //           fontWeight: FontWeight.w400,
        //           color: textPrimaryColor),
        //       confirmBtnText: 'Ok',
        //       confirmBtnTextStyle: GoogleFonts.montserrat(
        //           fontSize: 13,
        //           fontWeight: FontWeight.w400,
        //           color: Colors.white),
        //       confirmBtnColor: redColor,
        //       onConfirmBtnTap: () async {
        //         try {
        //           Navigator.pop(context);
        //           controller.overlayEntry = Helper().show_loading(context);
        //           await auth_c.deleteAccountData();
        //           controller.overlayEntry?.remove();
        //           Get.offAllNamed('/login');
        //         } catch (e) {
        //           controller.overlayEntry?.remove();
        //           String errorMessage = e is String
        //               ? e
        //               : 'Maaf ada kesalahan, silahkan coba lagi';
        //           Helper().Alert(null, errorMessage, context);
        //         }
        //       },
        //     );
        //   },
        //   child: Container(
        //       // color: Colors.white,
        //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           border: Border(
        //             left: BorderSide(
        //               color: Colors.grey.shade300,
        //               width: 1.0,
        //             ),
        //             right: BorderSide(
        //               color: Colors.grey.shade300,
        //               width: 1.0,
        //             ),
        //             top: BorderSide(
        //               color: Colors.grey.shade300,
        //               width: 1.0,
        //             ),
        //             bottom: BorderSide(
        //               color: Colors.grey.shade300,
        //               width: 1.0,
        //             ),
        //           )),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Row(
        //             children: [
        //               // Icon(
        //               //   Icons.logout,
        //               //   color: Colors.red,
        //               // ),
        //               Text(
        //                 'Hapus Akun',
        //                 style: GoogleFonts.montserrat(
        //                     fontSize: 13, fontWeight: FontWeight.w400),
        //               ),
        //             ],
        //           ),
        //         ],
        //       )),
        // ),
        // const SizedBox(height: 20),
        GestureDetector(
          onTap: () async {
            await auth_c.logoutData();
          },
          child: Container(
            // color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Colors.grey.shade300, width: 1.0),
                right: BorderSide(color: Colors.grey.shade300, width: 1.0),
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
                top: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon(
                    //   Icons.logout,
                    //   color: Colors.red,
                    // ),
                    Text(
                      'Log out',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
    ;
  }
}
