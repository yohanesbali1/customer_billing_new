import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/modules/auth/controller/auth_controller.dart';
import 'package:customer_billing/app/modules/home/home_controller.dart';
import 'package:customer_billing/app/modules/profile/profile_controller.dart';
import 'package:customer_billing/app/modules/profile/widget/list_menu_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final auth_c = Get.find<AuthController>();
    final home_c = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
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
              icon: Icon(Icons.arrow_back), // Custom back icon
              onPressed: () {
                // Define the action for the back button (e.g., navigate to the previous screen)
                home_c.change_page(0); // Go back to the previous screen
              })),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(padding: EdgeInsets.zero, children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/avatar.png"),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 16),
                child: Obx(
                  () => Text(
                    '${auth_c.profile.value?.name ?? '-'}',
                    textAlign: TextAlign.center,
                    style: monseratTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 4, bottom: 30),
              child: Text(
                '${auth_c.profile.value?.code ?? '-'}',
                textAlign: TextAlign.center,
                style: monseratTextFont.copyWith(
                    fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ),
            ListMenuProfile(controller: controller)
          ])),
    );
  }
}
