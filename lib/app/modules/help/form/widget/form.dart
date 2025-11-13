import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/core/widgets/form.dart';
import 'package:vigo_customer_billing/app/modules/help/form/controllers/help_form_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/form/widget/modal_location.dart';
import 'package:vigo_customer_billing/app/modules/help/form/widget/modal_type_topic.dart';

class FormHelpWidget extends GetView<HelpFormController> {
  const FormHelpWidget();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formkey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomFormLabel('Tipe Gangguan'),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ModalTypeTopic(),
                    );
                    FocusScope.of(context).unfocus();
                  },
                  child: AbsorbPointer(
                    child: CustomFormField(
                      label: 'Tipe Gangguan',
                      placeholder: 'Pilih tipe gangguan',
                      controller: controller.typeTopicController,
                      type: FormFieldType.text,
                      disabled: true,
                      isLoading: controller.isLoading.value,
                      validator: (value) => controller.validator_input(value),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Obx(
              () => CustomFormField(
                label: 'Permasalahan',
                placeholder: 'Masukkan permasalahan',
                controller: controller.descriptionController,
                type: FormFieldType.textarea,
                disabled: false,
                isLoading: controller.isLoading.value,
                validator: (value) => controller.validator_input(value),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Obx(
              () => CustomFormField(
                label: 'No HP',
                placeholder: 'Masukkan no hp',
                controller: controller.phoneController,
                type: FormFieldType.text,
                isLoading: controller.isLoading.value,
                validator: (value) => controller.validator_input(value),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Obx(
              () => CustomFormField(
                label: 'Alamat',
                placeholder: 'Masukkan alamat',
                controller: controller.addressController,
                type: FormFieldType.textarea,
                isLoading: controller.isLoading.value,
                validator: (value) => controller.validator_input(value),
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(bottom: 16),
          //   child: Obx(
          //     () => CustomFormField(
          //       label: 'No HP',
          //       placeholder: 'Masukkan no hp',
          //       controller: controller.addressController,
          //       type: FormFieldType.textarea,
          //       isLoading: controller.isLoading.value,
          //       validator: (value) => controller.validator_input(value),
          //     ),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CustomFormLabel('Gambar'),
                SizedBox(height: 10),
                Obx(
                  () => Container(
                    height: 250,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: borderboxColor, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: controller.image.value != null
                          ? Image.file(
                              controller.image.value!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit
                                  .cover, // Use BoxFit.fill if you want stretching instead
                            )
                          :
                            // Empty state if no image
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                  color: borderboxColor,
                                ),
                                Text(
                                  'Pilih Gambar',
                                  style: GoogleFonts.montserrat(
                                    color: borderboxColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // showModalMenuCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                    child: Text(
                      'Ambil Gambar',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: controller.pickImage,
                //     child: Text('test'))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomFormLabel('Map'),
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
                              flags:
                                  InteractiveFlag.all & ~InteractiveFlag.rotate,
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
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                        ),
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
          ),
        ],
      ),
    );
  }
}
