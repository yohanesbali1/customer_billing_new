import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/modules/history/datail/invoice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalBank extends GetView<InvoiceController> {
  const ModalBank({super.key});

  @override
  Widget build(BuildContext context) {
    final data = controller.list_bank.value;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 40.0,
              bottom: 14.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Pilih bank',
                  style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            // Add Expanded here to make ListBank scrollable
            child: ListBank(controller, data),
          ),
        ],
      ),
    );
  }

  Widget ListBank(controller, data) {
    String _selectedOption = 'Option 1';
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data != null ? data.length : 0,
      itemBuilder: (BuildContext context, int index_g) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 14.0,
              ),
              child: Text(
                controller.bank_group(data[index_g].group),
                style: GoogleFonts.montserrat(
                    color: textPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )),
          SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics:
                NeverScrollableScrollPhysics(), // Disable inner ListView scrolling
            itemCount: data != null && data[index_g].data != null
                ? data[index_g].data.length
                : 0,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                controller.choses_bank(data[index_g].data[index]);
                Navigator.pop(context);
              },
              child: Container(
                child: Container(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10,
                      bottom: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              '${data[index_g].data[index].img}',
                              width: 60,
                              filterQuality: FilterQuality.high,
                              height: 40,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: mainColor,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error,
                                        size: 30, color: Colors.red),
                                  ],
                                );
                              },
                              // ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              data[index_g].data[index].name,
                              style: GoogleFonts.montserrat(
                                color: textPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
          ),
        ],
      ),
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: 20,
      ),
    );
  }
}
