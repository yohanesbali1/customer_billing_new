import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/not_found.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/modules/help/detail/controlllers/help_detail_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/detail/views/widget/image_widget.dart';
import 'package:vigo_customer_billing/app/modules/help/detail/views/widget/status_widget.dart';
import 'package:vigo_customer_billing/app/modules/help/widget/skeleton_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailHelpPage extends GetView<HelpDetailController> {
  final FocusNode _buttonFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Detail Bantuan',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          MenuAnchor(
            childFocusNode: _buttonFocusNode,
            alignmentOffset: const Offset(-80, 0),
            style: MenuStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            menuChildren: <Widget>[
              SizedBox(
                width: 100, // Set desired width here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuItemButton(
                      onPressed: () {
                        Get.toNamed('/help/update/${controller.id.value}');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16, color: textPrimaryColor),
                          SizedBox(width: 5),
                          Text(
                            'Ubah',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MenuItemButton(
                      onPressed: () async {
                        bool confirm = await Helper().AlertGetX(
                          type: 'question',
                        );
                        if (confirm) {
                          await controller.deleteData();
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: textPrimaryColor),
                          SizedBox(width: 5),
                          Text(
                            'Hapus',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            builder: (_, MenuController controller, Widget? child) {
              return IconButton(
                focusNode: _buttonFocusNode,
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_vert),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        final data = controller.reportData.value;
        if (controller.isLoading.value) {
          return SkeletonReportDetail();
        }
        if (controller.reportData.value == null) {
          return NotFoundPage();
        }
        return RefreshIndicator(
          color: mainColor,
          onRefresh: () async {
            final String id = Get.parameters['id'] ?? '';
            if (id.isNotEmpty) return await controller.getData(id);
          },
          child: data == null
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: NotFoundPage(),
                  ),
                )
              : buildReportItem(
                  controller.reportData.value as HelpModel,
                  context,
                ),
        );
      }),
    );
  }

  Widget buildReportItem(HelpModel data, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    'Internet Lost',
                    style: GoogleFonts.montserrat(
                      color: textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        // width: MediaQuery.of(context).size.width * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tiket ID ',
                              style: GoogleFonts.montserrat(
                                color: textSecondaryColor,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              data.noTicket,
                              style: GoogleFonts.montserrat(
                                color: textPrimaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jenis Gangguan',
                              style: GoogleFonts.montserrat(
                                color: textSecondaryColor,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              data.disorderCategory.name,
                              style: GoogleFonts.montserrat(
                                color: textPrimaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tgl. Pesanan',
                              style: GoogleFonts.montserrat(
                                color: textSecondaryColor,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              DateFormat("d MMMM yyyy").format(data.createdAt),
                              style: GoogleFonts.montserrat(
                                color: textPrimaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Map',
                              style: GoogleFonts.montserrat(
                                color: textSecondaryColor,
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            GestureDetector(
                              onTap: () async {
                                controller.openWebsite(data);
                              },
                              child: Text(
                                'Link maps',
                                style: GoogleFonts.montserrat(
                                  color: mainColor,
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi',
                      style: GoogleFonts.montserrat(
                        color: textSecondaryColor,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      data.description,
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Komplain',
                      style: GoogleFonts.montserrat(
                        color: textSecondaryColor,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      data.complaint,
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Alamat ',
                      style: GoogleFonts.montserrat(
                        color: textSecondaryColor,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      data?.address ?? '',
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Petugas',
                      style: GoogleFonts.montserrat(
                        color: textSecondaryColor,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      data?.officer?.name ?? 'Tidak ada petugas',
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unit',
                      style: GoogleFonts.montserrat(
                        color: textSecondaryColor,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      data?.unit ?? '-',
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gambar',
                      style: GoogleFonts.montserrat(
                        color: textSecondaryColor,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    ImageWidget(data: data),
                  ],
                ),
              ],
            ),
          ),
          Text(
            'Status Penanganan',
            style: GoogleFonts.montserrat(
              color: textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          StatusWidget(data: data),
          SizedBox(height: 28),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgthirdColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              'Chat Customer Service',
              style: monseratTextFont.copyWith(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Get.toNamed('/help/chat/${controller.id}');
            },
          ),
        ],
      ),
    );
  }
}
