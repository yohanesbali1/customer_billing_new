import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vigo_customer_billing/app/modules/dashboard/widget/card_member/card_member.dart';
import 'package:vigo_customer_billing/app/modules/dashboard/widget/header_dashboard/header_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(
          0xFF690305,
        ), // warna top gradient HeaderDashboard
        automaticallyImplyLeading: false, // kalau gak mau tombol back otomatis
        title: Container(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang, ',
                      style: monseratTextFont.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Obx(
                      () => Skeletonizer(
                        enabled: controller.application_c.isLoading.value,
                        child: Text(
                          '${controller.application_c.accountbillData.value?.customer.name ?? 'Tidak Diketahui'}',
                          style: monseratTextFont.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  Get.toNamed('/notification');
                },
              ),

              Obx(() {
                int count = controller.total_unread.value;

                if (count == 0) return SizedBox();

                String displayCount = count > 99 ? "99+" : count.toString();

                return Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      displayCount,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        color: mainColor,
        onRefresh: () {
          controller.application_c.getData();
          controller.getData();
          return Future.value(true);
        },
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 240,
                    child: Stack(
                      children: [
                        HeaderDashboard(),
                        Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          child: CardMember(
                            controller: controller.application_c,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                    margin: EdgeInsets.only(
                      top: 0,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                              controller.home_c.change_page(2);
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
                              controller.home_c.change_page(1);
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
        ),
      ),
    );

    // ])));
  }
}
