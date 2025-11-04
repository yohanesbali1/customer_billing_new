import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/form.dart';
import 'package:vigo_customer_billing/app/modules/home/home_controller.dart';
import 'package:vigo_customer_billing/app/modules/profile/update_password/update_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  final home_c = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Kembali',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: controller.formkey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel('Password Lama'),
                        Obx(
                          () => CustomFormInput(
                            isLoading: controller.isLoading.value,
                            placeholder: 'Masukkan password lama',
                            controller: controller.password.value,
                            status: controller.password_status.value,
                            validator_input_text: controller.validator_input,
                            change_type: controller.password_status,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel('Password Baru'),
                        Obx(() {
                          return CustomFormInput(
                            isLoading: controller.isLoading.value,
                            placeholder: 'Masukkan password baru',
                            controller: controller.new_password.value,
                            type: 'password',
                            validator_input_text: controller.validator_password,
                            status: controller.new_password_status.value,
                            change_type: controller.new_password_status,
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel('Konfirmasi Password'),
                        Obx(() {
                          return CustomFormInput(
                            isLoading: controller.isLoading.value,
                            placeholder: 'Masukkan password baru',
                            controller: controller.c_password.value,
                            type: 'c_password',
                            validator_input_text:
                                controller.validator_c_password,
                            status: controller.c_password_status.value,
                            change_type: controller.c_password_status,
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24, bottom: 16),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.formkey.currentState!.validate()) {
                          await controller.update_password();
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
                        "Simpan Perubahan",
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
          ],
        ),
      ),
    );
  }
}
