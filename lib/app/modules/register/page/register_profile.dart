import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/form.dart';
import 'package:vigo_customer_billing/app/modules/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Registrasi Akun',
          style: monseratTextFont.copyWith(
            color: Color(0xFF0F1B26),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormLabel('Nama Lengkap'),
                  // //CustomFormInput('Masukan nama lengkap anda'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormLabel('Email'),
                  // //CustomFormInput('Masukan email anda'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormLabel('Username'),
                  //  //CustomFormInput('Masukan username anda'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormLabel('Nama Lengkap'),
                  //CustomFormInput('Masukan nama lengkap anda'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormLabel('Nomor Handphone'),
                  //CustomFormInput('Masukan nomor handphone anda'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormLabel('Password '),
                  //CustomFormInput('Masukan password anda'),
                  SizedBox(height: 8),
                  Text(
                    'Minimal 8 karakter yang berisikan gabungan dari huruf, Kapital, angka dan simbol',
                    style: monseratTextFont.copyWith(
                      fontSize: 13,
                      color: textSecondaryColor,
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
                  CustomFormLabel('Konfirmasi Password'),
                  //CustomFormInput('Masukan password kembali'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/register/path');
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
          ],
        ),
      ),
    );
  }
}
