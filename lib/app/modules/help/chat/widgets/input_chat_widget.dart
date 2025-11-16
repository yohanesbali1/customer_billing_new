import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/controllers/help_chat_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/chat/widgets/menu_option_camera_widget.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HelpChatController controller = Get.find<HelpChatController>();
    return Container(
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
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return MenuOptionCameraWidget();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: mainColor,
                  padding: EdgeInsets.all(0),
                ),
                child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
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
                onPressed: () async {
                  if (controller.formkey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    await controller.submit_data();
                  }
                },
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
    );
  }
}
