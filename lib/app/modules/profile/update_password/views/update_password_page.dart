import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/form.dart';
import 'package:vigo_customer_billing/app/modules/profile/update_password/controllers/update_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Kembali',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Form(
            key: controller.formkey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 20),
                  child: Obx(
                    () => CustomFormField(
                      label: 'Password Lama',
                      placeholder: 'Masukkan password lama',
                      controller: controller.passwordController,
                      type: FormFieldType.password,
                      isLoading: controller.isLoading.value,
                      validator: (value) => controller.validatorPassword(value),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Obx(
                    () => CustomFormField(
                      label: 'Password Baru',
                      placeholder: 'Masukkan password baru',
                      controller: controller.newPasswordController,
                      type: FormFieldType.password,
                      isLoading: controller.isLoading.value,
                      validator: (value) => controller.validatorPassword(value),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Obx(
                    () => CustomFormField(
                      label: 'Konfirmasi Password',
                      placeholder: 'Masukkan konfirmasi password',
                      controller: controller.cPasswordController,
                      type: FormFieldType.password,
                      isLoading: controller.isLoading.value,
                      validator: (value) => controller.validatorConfirmPassword(
                        value,
                        controller.newPasswordController,
                      ),
                    ),
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
        ),
      ),
    );
  }
}
