import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/modules/dashboard/dashboard_controller.dart';
import 'package:customer_billing/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/clip_path/card_member_clip_path.dart';
import 'widget/clip_path/header_dashboard_clip_path.dart';

class DashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    final home_c = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        child: RefreshIndicator(
          color: mainColor,
          onRefresh: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.getData();
              controller.auth_c.getData();
            });
            return Future.value(true);
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Container(width: double.infinity, height: 330),
                  HeaderDashboard(),
                  CardMember(controller: controller),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                margin: EdgeInsets.only(
                  bottom: 18,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      'Layanan Kami',
                      style: monseratTextFont.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/service');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFAC0205), Color(0xFFAC0205)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Koneksi internet ngebut dirumah.',
                                    style: monseratTextFont.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pasang Internet Home',
                                        style: monseratTextFont.copyWith(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons
                                            .keyboard_double_arrow_right_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 69,
                                maxHeight: 62,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/service.png",
                                  ),
                                ),
                              ),
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                margin: EdgeInsets.only(
                  bottom: 18,
                  left: defaultMargin,
                  right: defaultMargin,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 16,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/package/detail');
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.wifi, color: iconColor, size: 30),
                              SizedBox(height: 5),
                              Text(
                                'Detail\nLangganan',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          home_c.change_page(2);
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.message_rounded,
                                color: iconColor,
                                size: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Pengaduan',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          home_c.change_page(1);
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.list_alt_rounded,
                                color: iconColor,
                                size: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Tagihan',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/faq');
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.assignment_outlined,
                                color: iconColor,
                                size: 30,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'FAQ',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ],
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
      ),
    );

    // ])));
  }
}
