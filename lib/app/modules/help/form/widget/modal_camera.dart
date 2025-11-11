import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class CameraPickerSheet extends StatelessWidget {
  final dynamic
  controller; // bisa diganti dengan tipe spesifik kalau kamu punya
  final Color borderColor;

  const CameraPickerSheet({
    Key? key,
    required this.controller,
    this.borderColor = const Color(0xFFDDDDDD),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          ListTile(
            title: Text(
              "Ambil Dari Kamera",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              controller.pickImage(ImageSource.camera);
            },
          ),
          Divider(height: 0.5, thickness: 0.5, color: borderColor),
          ListTile(
            title: Text(
              "Ambil Dari Galeri",
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Get.back();
              controller.pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
