import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/modules/dashboard/dashboard_controller.dart';
import 'package:customer_billing/app/modules/dashboard/widget/not_found/card_member_not_found.dart';
import 'package:customer_billing/app/modules/dashboard/widget/skeleton/card_member_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardMember extends StatelessWidget {
  final DashboardController controller;
  const CardMember({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 130,
      left: 0,
      right: 0,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: SkeletonCardMember());
        }
        if (controller.accountbillData.value == null) {
          return Center(child: NotFoundCardMember());
        }
        final data = controller.accountbillData.value as AccountBillModel;
        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: false,
            viewportFraction: 1,
          ),
          items: data.orders.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return CompData(data, item);
              },
            );
          }).toList(),
        );
      }),
    );
  }

  Widget CompData(AccountBillModel data, Order item) {
    return ClipPath(
      clipper: CardMemberClipPath(),
      child: Container(
        width: double.infinity,
        height: 120,
        margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEF8200), Color(0xFF212360)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: bgColor, width: 0.9)),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${data.customer.code}',
                          style: monseratTextFont.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${data.customer.subCompany?.code}',
                          style: monseratTextFont.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Paket ',
                                    style: monseratTextFont.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: data.status == 'active'
                                          ? greenColor
                                          : redColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${data.status == 'active' ? 'Aktif' : 'Non Aktif'}',
                                      style: monseratTextFont.copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${item.productName}',
                                style: monseratTextFont.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: mainColor,
                        //     padding: EdgeInsets.symmetric(
                        //         vertical: 8, horizontal: 16),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(6),
                        //     ),
                        //   ),
                        //   onPressed: () {},
                        //   child: Text(
                        //     'RINCIAN',
                        //     style: monseratTextFont.copyWith(
                        //         color: Colors.white,
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w400,
                        //         fontStyle: FontStyle.italic),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Berlaku sampai ',
                        style: monseratTextFont.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '${DateFormat('dd MMMM yyyy').format(data.endDate)}',
                        style: monseratTextFont.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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

class CardMemberClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const fixedHeight = 160.0;

    Path path = Path();
    path.moveTo(8, 0);
    path.lineTo(size.width - 8, 0);
    path.cubicTo(size.width - 4, 0, size.width, 3.58, size.width, 8);
    path.lineTo(size.width, fixedHeight - 39.42);
    path.cubicTo(
      size.width,
      fixedHeight - 37.32,
      size.width - 0.82,
      fixedHeight - 35.31,
      size.width - 2.29,
      fixedHeight - 33.81,
    );
    path.lineTo(size.width - 33.18, fixedHeight - 2.39);
    path.cubicTo(
      size.width - 34.68,
      fixedHeight - 0.86,
      size.width - 36.74,
      fixedHeight,
      size.width - 38.88,
      fixedHeight,
    );
    path.lineTo(8, fixedHeight);
    path.cubicTo(3.58, fixedHeight, 0, fixedHeight - 3.58, 0, fixedHeight - 8);
    path.lineTo(0, 8);
    path.cubicTo(0, 3.58, 3.58, 0, 8, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
