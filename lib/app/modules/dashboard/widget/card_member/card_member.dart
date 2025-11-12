import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'card_member_clipper.dart';
import 'card_member_not_found.dart';
import 'card_member_skeleton.dart';

class CardMember extends StatelessWidget {
  final ApplicationControllers controller;
  const CardMember({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return SkeletonCardMember();
      }

      final data = controller.accountbillData.value;
      if (data == null) {
        return const Center(child: NotFoundCardMember());
      }

      final accountBill = data as AccountBillModel;

      return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: false,
          viewportFraction: 1,
        ),
        items: accountBill.orders.map((order) {
          return Builder(
            builder: (context) => _MemberCard(data: accountBill, order: order),
          );
        }).toList(),
      );
    });
  }
}

class _MemberCard extends StatelessWidget {
  final AccountBillModel data;
  final Order order;

  const _MemberCard({required this.data, required this.order});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CardMemberClipPath(),
      child: Container(
        // width: double.infinity,
        // height: 120,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: const BoxDecoration(gradient: kRedGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), _buildFooter()],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: bgColor, width: 0.9)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(),
          const SizedBox(height: 6),
          _buildPackageInfo(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data.customer.code,
          style: monseratTextFont.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data.customer.subCompany?.code ?? '-',
          style: monseratTextFont.copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildPackageInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Paket ',
                    style: monseratTextFont.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: data.status == 'active' ? greenColor : redColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      data.status == 'active' ? 'Aktif' : 'Non Aktif',
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
                order.productName,
                style: monseratTextFont.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Row(
        children: [
          Text(
            'Berlaku sampai ',
            style: monseratTextFont.copyWith(color: Colors.white, fontSize: 13),
          ),
          Text(
            DateFormat('dd MMMM yyyy').format(data.endDate),
            style: monseratTextFont.copyWith(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
