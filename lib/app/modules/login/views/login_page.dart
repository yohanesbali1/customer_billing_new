import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/form_old.dart';
import 'package:vigo_customer_billing/app/core/widgets/from.dart';
import 'package:vigo_customer_billing/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 154,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 36, bottom: 4),
                          child: Text(
                            "Login dengan akun kamu",
                            style: monseratTextFont.copyWith(
                              color: textPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            "Hello, Selamat datang kembali",
                            style: monseratTextFont.copyWith(
                              color: textSecondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                "Username",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Obx(
                                () => CustomInputField(
                                  controller: controller.usernameController,
                                  hintText: 'Masukkan Judul',
                                  errorText: controller.usernameError.value,
                                  onChanged: (_) =>
                                      controller.validateUsername(),
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
                                "Pasword",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Obx(
                                () => CustomInputField(
                                  controller: controller.passwordController,
                                  hintText: 'Masukkan password',
                                  isPassword: true,
                                  errorText: controller.passwordError.value,
                                  isTextArea: true,
                                  onChanged: (_) =>
                                      controller.validatePassword(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                await controller.submit_login();
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
                              "Masuk",
                              style: monseratTextFont.copyWith(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(top: 16),
                        //       child: Text(
                        //         "Belum punya akun?",
                        //         style: monseratTextFont.copyWith(
                        //           color: textSecondaryColor,
                        //           fontSize: 13,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: const EdgeInsets.only(top: 16, left: 4),
                        //       child: TextButton(
                        //           onPressed: () {
                        //             controller.submit_login();
                        //           },
                        //           child: Text(
                        //             "Pasang Wifi Baru",
                        //             style: monseratTextFont.copyWith(
                        //               color: mainColor,
                        //               fontSize: 13,
                        //               fontWeight: FontWeight.w600,
                        //             ),
                        //             textAlign: TextAlign.left,
                        //           )),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
