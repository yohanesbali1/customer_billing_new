import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Ganti sesuai project kamu
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/form/controllers/help_form_controller.dart';

class ModalTypeTopic extends GetView<HelpFormController> {
  const ModalTypeTopic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min, // biar tinggi secukupnya
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              child: Obx(
                () => CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32,
                  scrollController: FixedExtentScrollController(
                    initialItem: controller.type_topic_select,
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    controller.type_topic_select = selectedItem;
                  },
                  children: controller.type_topic_data.map((item) {
                    return Center(
                      child: Text(
                        item.name,
                        style: GoogleFonts.montserrat(
                          color: textPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity, // full width
              child: ElevatedButton(
                onPressed: () {
                  controller.select_type_data();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: GoogleFonts.montserrat(
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
    );
  }
}
