import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/form/controllers/help_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/modules/help/form/widget/form.dart';

class FormHelpPage extends GetView<HelpFormController> {
  @override
  Widget build(BuildContext context) {
    // void showDialog(Widget child) {
    //   showCupertinoModalPopup<void>(
    //     context: context,
    //     builder: (BuildContext context) => Container(
    //       height: 216,
    //       padding: const EdgeInsets.only(top: 6.0),
    //       margin: EdgeInsets.only(
    //         bottom: MediaQuery.of(context).viewInsets.bottom,
    //       ),
    //       color: CupertinoColors.systemBackground.resolveFrom(context),
    //       child: SafeArea(top: false, child: child),
    //     ),
    //   );
    // }

    // void showModalMenuCamera() {
    //   showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: false,
    //     backgroundColor: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    //     ),
    //     builder: (context) {
    //       return CameraPickerSheet(controller: controller);
    //     },
    //   );
    // }

    // void _showSheet(BuildContext context) {
    //   showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true, // ini penting!
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    //     ),
    //     builder: (context) {
    //       return Container(
    //         decoration: BoxDecoration(
    //           color: bgColor,
    //           borderRadius: const BorderRadius.vertical(
    //             top: Radius.circular(20),
    //           ),
    //         ),
    //         padding: EdgeInsets.only(
    //           bottom: MediaQuery.of(
    //             context,
    //           ).viewInsets.bottom, // untuk menghindari keyboard
    //         ),
    //         child: SingleChildScrollView(
    //           child: Obx(
    //             () => Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   SizedBox(height: 20),
    //                   Text(
    //                     'Cari Lokasi',
    //                     style: GoogleFonts.montserrat(
    //                       color: textinputColor,
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.w500,
    //                     ),
    //                   ),
    //                   SizedBox(height: 10),
    //                   TextFormField(
    //                     showCursor: true,
    //                     initialValue: controller.search.value,
    //                     cursorColor: mainColor,
    //                     autovalidateMode: AutovalidateMode.onUserInteraction,
    //                     style: GoogleFonts.montserrat(
    //                       color: textinputColor,
    //                       fontSize: 13,
    //                       fontWeight: FontWeight.w400,
    //                     ),
    //                     decoration: InputDecoration(
    //                       disabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(8),
    //                         borderSide: BorderSide(
    //                           color: borderboxColor,
    //                           width: 0.5,
    //                         ),
    //                       ),
    //                       enabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(8),
    //                         borderSide: BorderSide(
    //                           color: borderboxColor,
    //                           width: 0.5,
    //                         ),
    //                       ),
    //                       errorBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(8),
    //                         borderSide: BorderSide(
    //                           color: Colors.red,
    //                           width: 0.5,
    //                         ),
    //                       ),
    //                       focusedErrorBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(8),
    //                         borderSide: BorderSide(
    //                           color: Colors.red,
    //                           width: 0.5,
    //                         ),
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(8),
    //                         borderSide: BorderSide(
    //                           color: borderboxColor,
    //                           width: 0.5,
    //                         ),
    //                       ),
    //                       focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.circular(8),
    //                         borderSide: BorderSide(
    //                           color: borderinputColor,
    //                           width: 0.5,
    //                         ),
    //                       ),
    //                       errorStyle: GoogleFonts.montserrat(
    //                         color: Colors.red,
    //                         fontSize: 13,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                       filled: true,
    //                       fillColor: Colors.white,
    //                       hintText: 'Cari..',
    //                       hintStyle: GoogleFonts.montserrat(
    //                         color: textSecondaryColor,
    //                         fontSize: 13,
    //                         fontWeight: FontWeight.w400,
    //                       ),
    //                       contentPadding: EdgeInsets.symmetric(
    //                         horizontal: 12,
    //                         vertical: 12,
    //                       ),
    //                     ),
    //                     onChanged: (value) {
    //                       controller.search.value = value;
    //                     },
    //                   ),
    //                   Container(
    //                     height: 200,
    //                     padding: const EdgeInsets.only(top: 10),
    //                     child: ListView.separated(
    //                       shrinkWrap: true,
    //                       itemCount: controller.searchItem.length,
    //                       separatorBuilder: (context, index) =>
    //                           const SizedBox(height: 10),
    //                       itemBuilder: (context, index) => GestureDetector(
    //                         onTap: () {
    //                           controller.updateLocation(
    //                             LatLng(
    //                               controller.searchItem[index].lat,
    //                               controller.searchItem[index].lon,
    //                             ),
    //                           );
    //                           controller.search.value =
    //                               controller.searchItem[index].display_name;
    //                           Navigator.pop(context);
    //                         },
    //                         child: Container(
    //                           padding: const EdgeInsets.symmetric(
    //                             vertical: 10,
    //                             horizontal: 12,
    //                           ),
    //                           margin: const EdgeInsets.only(top: 10),
    //                           decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius: BorderRadius.circular(6),
    //                             boxShadow: [
    //                               BoxShadow(
    //                                 color: Colors.grey.shade300,
    //                                 spreadRadius: 0,
    //                                 blurRadius: 10,
    //                                 offset: Offset(0, 1),
    //                               ),
    //                             ],
    //                           ),
    //                           child: Text(
    //                             controller.searchItem[index].display_name,
    //                             style: GoogleFonts.montserrat(
    //                               fontWeight: FontWeight.w400,
    //                               fontSize: 14,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 20),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Kembali',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Form Bantuan",
                      style: monseratTextFont.copyWith(
                        color: textPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Lengkapi form berikut",
                      style: monseratTextFont.copyWith(
                        color: textPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              FormHelpWidget(),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.formkey.currentState!.validate() &&
                        controller.image.value != null) {
                      FocusScope.of(context).unfocus();
                      await controller.submit_data();
                    } else {
                      Helper().AlertGetX(
                        message: 'Cek kembali data yang anda masukkan',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    "Simpan",
                    style: monseratTextFont.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
