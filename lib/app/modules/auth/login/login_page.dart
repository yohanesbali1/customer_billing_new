import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/core/widgets/form.dart';
import 'package:customer_billing/app/modules/auth/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bgColor,
        body: Center(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(shrinkWrap: true, children: [
                  Form(
                    key: controller.formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 154,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"))),
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
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomFormLabel('Username'),
                              Obx(
                                () => CustomFormInput(
                                    isLoading: controller.isLoading.value,
                                    placeholder: 'Masukkan username anda',
                                    validator_input_text:
                                        controller.validator_input,
                                    controller: controller.username.value),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomFormLabel('Password'),
                              Obx(
                                () => CustomFormInput(
                                    status: controller.password_status.value,
                                    isLoading: controller.isLoading.value,
                                    placeholder: 'Masukkan password anda',
                                    validator_input_text:
                                        controller.validator_input,
                                    controller: controller.password.value,
                                    change_type: controller.password_status),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 24),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  // try {
                                  if (controller.formkey.currentState!
                                      .validate()) {
                                    FocusScope.of(context).unfocus();
                                    await controller.submit_login();
                                    // Navigator.of(context, rootNavigator: true)
                                    //     .pop();
                                    // Helper().Alert('loading', null, context);
                                  }
                                  // Get.offAllNamed('/home');
                                  // }
                                  // } catch (e) {
                                  //   // Navigator.of(context, rootNavigator: true)
                                  //   //     .pop();
                                  //   String errorMessage = e is String
                                  //       ? e
                                  //       : 'Maaf ada kesalahan, silahkan coba lagi';
                                  //   // WidgetsBinding.instance
                                  //   //     .addPostFrameCallback((_) async {
                                  //   //   await Helper()
                                  //   //       .Alert(null, errorMessage, context);
                                  //   // });
                                  // }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12)),
                                child: Text(
                                  "Masuk",
                                  style: monseratTextFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))),
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
                  )
                ]))));
  }

  void _hideLoadingOverlay() {
    controller.overlayEntry?.remove();
  }
}
