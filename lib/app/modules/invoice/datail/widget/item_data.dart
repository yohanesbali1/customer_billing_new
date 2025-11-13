import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/widget/guide.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/widget/bank_modal.dart';

class ItemDataInvoice extends StatelessWidget {
  final data;
  final controller;
  var applicationControllers = Get.find<ApplicationControllers>();
  ItemDataInvoice({required this.data, required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Invoice',
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 0),
                Text(
                  'Berikut adalah detail invoice',
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Invoice',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            data.numTransaction,
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tanggal',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            DateFormat("d MMMM yyyy").format(data.createdAt),
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      controller.change_status(data.status),
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Metode Pembayaran',
                      style: GoogleFonts.montserrat(
                        color: textPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    controller.bank_data.value?.guide != null
                        ? GestureDetector(
                            onTap: controller.isButtonDisabledCopy.value
                                ? null
                                : () async {
                                    controller.isButtonDisabledCopy.value =
                                        true;
                                    Clipboard.setData(
                                      ClipboardData(
                                        text:
                                            "${controller.bank_data.value!.code}${applicationControllers.accountbillData.value!.paymentCode}",
                                      ),
                                    );
                                    Helper().AlertSnackBar(
                                      status: "success",
                                      message:
                                          "Kode pembayaran berhasil dicopy",
                                    );
                                    await Future.delayed(2.seconds);
                                    controller.isButtonDisabledCopy(false);
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 15,
                              ),
                              child: Text(
                                "Salin",
                                style: monseratTextFont.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    data.status != 'paid'
                        ? showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(
                              context,
                            ).modalBarrierDismissLabel,
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionDuration: Duration(milliseconds: 300),
                            pageBuilder: (context, animation1, animation2) {
                              return Container();
                            },
                            transitionBuilder:
                                (context, animation1, animation2, child) {
                                  return SlideTransition(
                                    position:
                                        Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(
                                          CurvedAnimation(
                                            parent: animation1,
                                            curve: Curves.easeInOut,
                                          ),
                                        ),
                                    child: Align(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: ModalBank(),
                                      ),
                                    ),
                                  );
                                },
                          )
                        : null;
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: borderboxColor, // Set the border color
                        width: 0.5, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.bank_data.value != null
                                ? Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Image.network(
                                          '${controller.bank_data.value?.img}',
                                          loadingBuilder:
                                              (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: mainColor,
                                                      ),
                                                );
                                              },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.error,
                                                      size: 30,
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                );
                                              },
                                          width: 45,
                                          height: 30,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.bank_data.value!.name,
                                              style: GoogleFonts.montserrat(
                                                color: textPrimaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            controller
                                                        .bank_data
                                                        .value!
                                                        .uniq_name !=
                                                    'CASH'
                                                ? Text(
                                                    controller
                                                                .bank_data
                                                                .value
                                                                ?.code !=
                                                            null
                                                        ? "${controller.bank_data.value!.code}${applicationControllers.accountbillData.value?.paymentCode ?? '-'}"
                                                        : "",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          color:
                                                              textPrimaryColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Text('Pilih Bank'),
                            SizedBox(width: 10),
                            data.status != 'paid'
                                ? controller.bank_data.value != null
                                      ? Row(
                                          children: [
                                            Text(
                                              'Ganti',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: mainColor,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 12,
                                              color: mainColor,
                                            ),
                                          ],
                                        )
                                      : Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 12,
                                        )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                controller.bank_data.value?.guide != null
                    ? GuideData(controller: controller)
                    : Container(),
                const SizedBox(height: 20),
                Text(
                  'Rincian Pembayaran',
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: borderboxColor, // Set the border color
                      width: 0.5, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.order.length,
                        itemBuilder: (context, index) {
                          final item = data.order[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.productName}',
                                style: GoogleFonts.montserrat(
                                  color: textPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${Helper.formatRupiah(item.productPrice)}',
                                style: GoogleFonts.montserrat(
                                  color: textPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 10),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Admin',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${Helper.formatRupiah(controller.bank_data.value?.adminFee ?? 0)}',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: borderboxColor, // Set the border color
                      width: 0.5, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Total',
                              style: GoogleFonts.montserrat(
                                color: textPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '${Helper.formatRupiah(data.price + (controller.bank_data.value?.adminFee ?? 0))}',
                            style: GoogleFonts.montserrat(
                              color: textPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
