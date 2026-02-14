import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/modules/help/form/controllers/help_form_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/form/widget/modal_location.dart';

class LocationWidget extends GetView<HelpFormController> {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lokasi",
            style: GoogleFonts.montserrat(
              color: textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(() {
            return SizedBox(
              height: 300,
              child: Stack(
                children: <Widget>[
                  FlutterMap(
                    mapController: controller.flutterMapController,
                    options: MapOptions(
                      initialCenter: LatLng(-8.6524973, 115.2191175),
                      interactionOptions: InteractionOptions(
                        enableMultiFingerGestureRace: false,
                        flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                      ),
                      onTap: (tapPosition, latlng) {
                        controller.isLoading.value
                            ? null
                            : controller.updateLocation(latlng);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'VIGO',
                      ),
                      if (controller.selectedLocation.value != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: controller.selectedLocation.value!,
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          //
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // ini penting!
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => const ModalLocation(),
                          );
                          // _showSheet(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.search.value != ""
                                      ? controller.search.value
                                      : 'Pilih Lokasi',
                                  style: GoogleFonts.montserrat(fontSize: 14),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      backgroundColor: mainColor,
                      onPressed: () {
                        controller.getCurrentLocation();
                      },
                      child: Icon(Icons.my_location),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
