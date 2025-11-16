import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/controllers/help_chat_controller.dart';

class MenuOptionCameraWidget extends StatelessWidget {
  const MenuOptionCameraWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HelpChatController controller = Get.find<HelpChatController>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          ListTile(
            title: Text(
              "Ambil Foto",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              controller.pickMedia(pickImage: true, source: ImageSource.camera);
            },
          ),
          Divider(height: 0.5, thickness: 0.5, color: borderboxColor),
          ListTile(
            title: Text(
              "Ambil Video",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              controller.pickMedia(
                pickImage: false,
                source: ImageSource.camera,
              );
            },
          ),
          Divider(height: 0.5, thickness: 0.5, color: borderboxColor),
          ListTile(
            title: Text(
              "Ambi Gambar Dari Galeri",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              controller.pickMedia(
                pickImage: true,
                source: ImageSource.gallery,
              );
            },
          ),
          Divider(height: 0.5, thickness: 0.5, color: borderboxColor),
          ListTile(
            title: Text(
              "Ambi Vidio Dari Galeri",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              controller.pickMedia(
                pickImage: false,
                source: ImageSource.gallery,
              );
            },
          ),
        ],
      ),
    );
    ;
  }
}
