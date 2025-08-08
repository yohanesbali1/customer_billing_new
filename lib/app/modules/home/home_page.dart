import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/modules/auth/controller/auth_controller.dart';
import 'package:customer_billing/app/modules/dashboard/dashboard_page.dart';
import 'package:customer_billing/app/modules/help/page/list_help_page.dart';
import 'package:customer_billing/app/modules/history/history_page.dart';
import 'package:customer_billing/app/modules/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth_c = Get.find<AuthController>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.pagecontroller,
                onPageChanged: (index) {
                  // setState(() {
                  //   bottomNavBarIndex = index;
                  // });
                },
                children: <Widget>[
                  DashboardPage(),
                  HistoryPage(),
                  HelpPage(),
                  ProfilePage(),
                ],
              ),
            ),
            createCustomBottomNavBar(),
          ],
        )));
  }

  Widget createCustomBottomNavBar() => Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              height: 52,
              margin: EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1E272E).withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  )
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        controller.change_page(0);
                      },
                      icon: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsetsDirectional.only(bottom: 4),
                              child: Obx(
                                () => ClipRRect(
                                    child: SvgPicture.asset(
                                  'assets/icons/home.svg',
                                  height: 15,
                                  width: 15,
                                  color: controller.page_index.value == 0
                                      ? mainColor
                                      : textSecondaryColor,
                                )),
                              )),
                          Obx(() => Text('Home',
                              style: monseratTextFont.copyWith(
                                  color: controller.page_index.value == 0
                                      ? mainColor
                                      : textSecondaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)))
                        ],
                      ))),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        controller.change_page(1);
                      },
                      icon: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsetsDirectional.only(bottom: 4),
                              child: Obx(
                                () => ClipRRect(
                                    child: SvgPicture.asset(
                                  'assets/icons/time.svg',
                                  height: 15,
                                  width: 15,
                                  color: controller.page_index.value == 1
                                      ? mainColor
                                      : textSecondaryColor,
                                )),
                              )),
                          Obx(() => Text('Riwayat',
                              style: monseratTextFont.copyWith(
                                  color: controller.page_index.value == 1
                                      ? mainColor
                                      : textSecondaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)))
                        ],
                      ))),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        controller.change_page(2);
                      },
                      icon: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsetsDirectional.only(bottom: 4),
                              child: Obx(
                                () => ClipRRect(
                                    child: SvgPicture.asset(
                                  'assets/icons/help.svg',
                                  height: 15,
                                  width: 15,
                                  color: controller.page_index.value == 2
                                      ? mainColor
                                      : textSecondaryColor,
                                )),
                              )),
                          Obx(() => Text('Bantuan',
                              style: monseratTextFont.copyWith(
                                  color: controller.page_index.value == 2
                                      ? mainColor
                                      : textSecondaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)))
                        ],
                      ))),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        controller.change_page(3);
                      },
                      icon: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsetsDirectional.only(bottom: 4),
                              child: Obx(
                                () => ClipRRect(
                                    child: SvgPicture.asset(
                                  'assets/icons/time.svg',
                                  height: 15,
                                  width: 15,
                                  color: controller.page_index.value == 3
                                      ? mainColor
                                      : textSecondaryColor,
                                )),
                              )),
                          Obx(() => Text('Profile',
                              style: monseratTextFont.copyWith(
                                  color: controller.page_index.value == 3
                                      ? mainColor
                                      : textSecondaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)))
                        ],
                      ))),
                ],
              ),
            ),
          ),
        ],
      ));
}
