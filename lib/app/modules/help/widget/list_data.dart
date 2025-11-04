import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/modules/help/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListDataReportPage extends StatelessWidget {
  final controller;
  const ListDataReportPage({required this.controller});

  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return SkeletonListReport();
      }
      if (controller.report_data.isEmpty) {
        return NotFoundPage();
      }
      return RefreshIndicator(
        color: mainColor,
        onRefresh: () {
          Future.microtask(() => controller.getData());
          return Future.value(true);
        },
        child: list_data(controller.report_data),
      );
    });
  }

  Widget list_data(data) => Container(
    margin: EdgeInsets.only(
      left: defaultMargin,
      right: defaultMargin,
      bottom: 10,
      top: 10,
    ),
    child: ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: data != null ? data.length : 0,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          Get.toNamed('/help/detail/${data[index].id}');
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 10,
          ),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.change_status(
                        data[index].status.status,
                      )['color'],
                    ),
                    child: Icon(
                      controller.change_status(
                        data[index].status.status,
                      )['icon'],
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    data[index].status.description,
                    style: GoogleFonts.montserrat(
                      color: controller.change_status(
                        data[index].status.status,
                      )['color'],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("d MMMM yyyy").format(data[index].createdAt),
                    style: GoogleFonts.montserrat(
                      color: textPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      data[index].typeTopic.type,
                      style: GoogleFonts.montserrat(
                        color: textSecondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Row(
                    children: [
                      Text(
                        'Lihat Detail',
                        style: GoogleFonts.montserrat(
                          color: mainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        '>',
                        style: GoogleFonts.montserrat(
                          color: mainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
    ),
  );
}
