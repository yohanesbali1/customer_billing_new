import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/controllers/help_chat_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/widgets/full_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ChatHelpPage extends GetView<HelpChatController> {
  void _showDropdownMenu(BuildContext context, Offset position, id) async {
    final selected = await showMenu(
      context: context,
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + 1,
        position.dy + 1,
      ),
      items: [
        PopupMenuItem(
          value: 'delete',
          height: 10,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: textPrimaryColor, size: 14),
              SizedBox(width: 5),
              Text(
                'Delete',
                style: GoogleFonts.montserrat(
                  color: textPrimaryColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (selected == 'delete') {
      bool confirm = await Helper().AlertGetX('question', null);
      if (confirm) {
        deleteData(id);
      }
    }
  }

  submitData(BuildContext context) async {
    if (controller.formkey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await controller.submit_data();
    }
  }

  deleteData(id) async {
    if (controller.formkey.currentState!.validate()) {
      await controller.delete_data(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.getData();

    void showModalMenuCamera() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
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
                    controller.pickMedia(
                      pickImage: true,
                      source: ImageSource.camera,
                    );
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
        },
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Chat',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: 10,
              ),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Container();
                }
                if (controller.data.isEmpty) {
                  return Container();
                }
                return RefreshIndicator(
                  color: mainColor,
                  onRefresh: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.getData();
                    });
                    return Future.value(true);
                  },
                  child: list_data(controller.data, context),
                );
              }),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Form(
              key: controller.formkey,
              child: Row(
                children: [
                  SizedBox(
                    height: 38,
                    width: 38,
                    child: ElevatedButton(
                      onPressed: () async {
                        showModalMenuCamera();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: mainColor,
                        padding: EdgeInsets.all(0),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 14,
                      ),
                      controller: controller.message.value,
                      decoration: InputDecoration(
                        hintText: "Ketik Pesan",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        fillColor: Colors.grey[100],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 38,
                    width: 38,
                    child: ElevatedButton(
                      onPressed: () => submitData(context),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: mainColor,
                        padding: EdgeInsets.all(0),
                      ),
                      child: ClipRRect(
                        child: SvgPicture.asset(
                          'assets/icons/send.svg',
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget list_data(data, context) {
    final size = MediaQuery.of(context).size;
    return
    // RefreshIndicator(
    //       onRefresh: controller.handleRefresh,
    //       child:
    ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.zero,
      itemCount: data.length,
      itemBuilder: (context, index) {
        ChatResponse chatResponse = data[index];
      },
      // ),
    );
  }
}
