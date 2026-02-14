import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/core/widgets/form_old.dart';
import 'package:vigo_customer_billing/app/core/widgets/from.dart';
import 'package:vigo_customer_billing/app/modules/help/form/controllers/help_form_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/form/widget/image_widget.dart';
import 'package:vigo_customer_billing/app/modules/help/form/widget/location_widget.dart';
import 'package:vigo_customer_billing/app/modules/help/form/widget/modal_type_topic.dart';

class FormHelpWidget extends GetView<HelpFormController> {
  const FormHelpWidget();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Judul",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => CustomInputField(
                    controller: controller.titleController,
                    hintText: 'Masukkan Judul',
                    errorText: controller.titleError.value,
                    isTextArea: true,
                    onChanged: (_) => controller.validateRequestDate(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomFormLabel('Tipe Gangguan'),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ModalTypeTopic(),
                    );
                    FocusScope.of(context).unfocus();
                  },
                  child: AbsorbPointer(
                    child: CustomInputField(
                      controller: controller.typeTopicController,
                      hintText: 'Pilih tipe gangguan',
                      errorText: controller.typeTopicError.value,
                      isTextArea: true,
                      onChanged: (_) => controller.validateTypeTopic(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Permasalahaan",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => CustomInputField(
                    controller: controller.complaintController,
                    hintText: 'Masukkan permasalahan',
                    errorText: controller.complaintError.value,
                    isTextArea: true,
                    onChanged: (_) => controller.validateComplaint(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Deskripsi Gangguan",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => CustomInputField(
                    controller: controller.descriptionController,
                    hintText: 'Masukkan deskripsi gangguan',
                    errorText: controller.descriptionError.value,
                    isTextArea: true,
                    onChanged: (_) => controller.validateRequestDate(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Tanggal Gangguan",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => CustomInputField(
                    controller: controller.requestDateController,
                    hintText: 'Masukkan tanggal gangguan',
                    errorText: controller.requestDateError.value,
                    isDate: true,
                    onChanged: (_) => controller.validateRequestDate(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Unit",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => CustomInputField(
                    controller: controller.unitController,
                    hintText: 'Masukkan unit',
                    errorText: controller.unitError.value,
                    isEditable: false,
                    onChanged: (_) => controller.validatePhone(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "No HP",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => CustomInputField(
                    controller: controller.phoneController,
                    hintText: 'Masukkan no hp',
                    errorText: controller.phoneError.value,
                    isTextArea: true,
                    onChanged: (_) => controller.validatePhone(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Alamat Gangguan",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Obx(
                  () => CustomInputField(
                    controller: controller.addressController,
                    hintText: 'Masukkan alamat gangguan',
                    errorText: controller.addressError.value,
                    isTextArea: true,
                    onChanged: (_) => controller.validateAddress(),
                  ),
                ),
              ],
            ),
          ),
          ImageWidget(),
          LocationWidget(),
        ],
      ),
    );
  }
}
