import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/profile/controllers/profile_controller.dart';
import 'package:vigo_customer_billing/app/modules/profile/widget/list_menu_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile',
          style: monseratTextFont.copyWith(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            controller.home_c.change_page(0);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/avatar.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Obx(
                () => Text(
                  '${controller.application_c.accountbillData.value?.customer.name ?? '-'}',
                  textAlign: TextAlign.center,
                  style: monseratTextFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4, bottom: 30),
              child: Text(
                '${controller.application_c.accountbillData.value?.customer.code ?? '-'}',
                textAlign: TextAlign.center,
                style: monseratTextFont.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListMenuProfile(controller: controller),
          ],
        ),
      ),
    );
  }
}
