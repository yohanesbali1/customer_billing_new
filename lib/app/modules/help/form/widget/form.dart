import 'package:flutter/widgets.dart';

class FormHelpWidget extends StatelessWidget {
  final controller;
  const FormHelpWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          // Container(
          //   margin: const EdgeInsets.only(bottom: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // CustomFormLabel('Tipe Gangguan'),
          //       GestureDetector(
          //         onTap: () {
          //           FocusScope.of(context).unfocus();
          //           showDialog(
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Expanded(
          //                   child: Obx(
          //                     () => CupertinoPicker(
          //                       magnification: 1.22,
          //                       squeeze: 1.2,
          //                       useMagnifier: true,
          //                       itemExtent: 32,
          //                       // This sets the initial item.
          //                       scrollController:
          //                           FixedExtentScrollController(
          //                             initialItem: controller
          //                                 .type_topic_select,
          //                           ),
          //                       // This is called when selected item is changed.
          //                       onSelectedItemChanged:
          //                           (int selectedItem) {
          //                             controller.type_topic_select =
          //                                 selectedItem;
          //                           },
          //                       children: controller.type_topic_data
          //                           .map((item) {
          //                             return Center(
          //                               child: Text(
          //                                 item.type,
          //                                 style:
          //                                     GoogleFonts.montserrat(
          //                                       color:
          //                                           textPrimaryColor,
          //                                       fontSize: 14,
          //                                       fontWeight:
          //                                           FontWeight.w400,
          //                                     ),
          //                               ),
          //                             );
          //                           })
          //                           .toList(),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: const EdgeInsets.only(bottom: 24),
          //                   child: ElevatedButton(
          //                     onPressed: () async {
          //                       controller.select_type_data();
          //                       Navigator.pop(context);
          //                     },
          //                     style: ElevatedButton.styleFrom(
          //                       backgroundColor: mainColor,
          //                       padding: EdgeInsets.symmetric(
          //                         vertical: 12,
          //                         horizontal: 20,
          //                       ),
          //                     ),
          //                     child: Text(
          //                       'Simpan',
          //                       style: GoogleFonts.montserrat(
          //                         color: Colors.white,
          //                         fontSize: 14,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //         // child: CustomFormField(
          //         //   label: 'Password Baru',
          //         //   placeholder: 'Masukkan password baru',
          //         //   controller: controller.newPasswordController,
          //         //   type: FormFieldType.password,
          //         //   isLoading: controller.isLoading.value,
          //         //   validator: (value) =>
          //         //       controller.validatorPassword(value),
          //         // ),

          //         // CustomFormInput(
          //         //   isLoading: controller.isLoading.value,
          //         //   placeholder: '',
          //         //   disabled: false,
          //         //   validator_input_text: controller.validator_input,
          //         //   controller: controller.type_topic_id.value,
          //         // ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomFormLabel('Permasalahan'),
                // Obx(
                //   () => CustomFormAreaInput(
                //     isLoading: controller.isLoading.value,
                //     placeholder: '',
                //     validator_input_text: controller.validator_input,
                //     controller: controller.description.value,
                //   ),
                // ),
              ],
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(bottom: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // CustomFormLabel('No HP'),
          //       // Obx(
          //       //   () => CustomFormInput(
          //       //     isLoading: controller.isLoading.value,
          //       //     placeholder: '',
          //       //     type_keyboard: 'number',
          //       //     validator_input_text: controller.validator_input,
          //       //     controller: controller.phone.value,
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(bottom: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // CustomFormLabel('Alamat'),
          //       // Obx(
          //       //   () => CustomFormAreaInput(
          //       //     isLoading: controller.isLoading.value,
          //       //     placeholder: '',
          //       //     validator_input_text: controller.validator_input,
          //       //     controller: controller.address.value,
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(bottom: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       // CustomFormLabel('Gambar'),
          //       SizedBox(height: 10),
          //       Obx(
          //         () => Container(
          //           height: 250,
          //           width: double.infinity,
          //           padding: const EdgeInsets.all(8),
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             border: Border.all(
          //               color: borderboxColor,
          //               width: 0.5,
          //             ),
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(8),
          //             child: controller.image.value != null
          //                 ? Image.file(
          //                     controller.image.value!,
          //                     width: double.infinity,
          //                     height: double.infinity,
          //                     fit: BoxFit
          //                         .cover, // Use BoxFit.fill if you want stretching instead
          //                   )
          //                 :
          //                   // Empty state if no image
          //                   Column(
          //                     mainAxisAlignment:
          //                         MainAxisAlignment.center,
          //                     children: [
          //                       Icon(
          //                         Icons.camera_alt_outlined,
          //                         size: 50,
          //                         color: borderboxColor,
          //                       ),
          //                       Text(
          //                         'Pilih Gambar',
          //                         style: GoogleFonts.montserrat(
          //                           color: borderboxColor,
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.w400,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.only(top: 10),
          //         width: double.infinity,
          //         child: ElevatedButton(
          //           onPressed: () async {
          //             showModalMenuCamera();
          //           },
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: mainColor,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             padding: EdgeInsets.symmetric(
          //               vertical: 12,
          //               horizontal: 20,
          //             ),
          //           ),
          //           child: Text(
          //             'Ambil Gambar',
          //             style: GoogleFonts.montserrat(
          //               color: Colors.white,
          //               fontSize: 14,
          //             ),
          //           ),
          //         ),
          //       ),
          //       // ElevatedButton(
          //       //     onPressed: controller.pickImage,
          //       //     child: Text('test'))
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(bottom: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // CustomFormLabel('Map'),
          //       Obx(() {
          //         return SizedBox(
          //           height: 300,
          //           child: Stack(
          //             children: <Widget>[
          //               FlutterMap(
          //                 mapController:
          //                     controller.flutterMapController,
          //                 options: MapOptions(
          //                   initialCenter: LatLng(
          //                     -8.6524973,
          //                     115.2191175,
          //                   ),
          //                   interactionOptions: InteractionOptions(
          //                     enableMultiFingerGestureRace: false,
          //                     flags:
          //                         InteractiveFlag.all &
          //                         ~InteractiveFlag.rotate,
          //                   ),
          //                   onTap: (tapPosition, latlng) {
          //                     controller.isLoading.value
          //                         ? null
          //                         : controller.updateLocation(latlng);
          //                   },
          //                 ),
          //                 children: [
          //                   TileLayer(
          //                     urlTemplate:
          //                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          //                     userAgentPackageName: 'VIGO',
          //                   ),
          //                   if (controller.selectedLocation.value !=
          //                       null)
          //                     MarkerLayer(
          //                       markers: [
          //                         Marker(
          //                           point: controller
          //                               .selectedLocation
          //                               .value!,
          //                           width: 40,
          //                           height: 40,
          //                           child: Icon(
          //                             Icons.location_on,
          //                             color: Colors.red,
          //                             size: 30,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                 ],
          //               ),
          //               Positioned(
          //                 top: 0,
          //                 left: 0,
          //                 right: 0,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: GestureDetector(
          //                     onTap: () {
          //                       return controller.isLoading.value
          //                           ? null
          //                           : _showSheet(context);
          //                     },
          //                     child: Container(
          //                       padding: EdgeInsets.symmetric(
          //                         vertical: 10,
          //                         horizontal: 12,
          //                       ),
          //                       decoration: BoxDecoration(
          //                         color: Colors.white,
          //                       ),
          //                       child: Row(
          //                         children: [
          //                           Expanded(
          //                             child: Text(
          //                               controller.search.value != ""
          //                                   ? controller.search.value
          //                                   : 'Pilih Lokasi',
          //                               style: GoogleFonts.montserrat(
          //                                 fontSize: 14,
          //                               ),
          //                             ),
          //                           ),
          //                           Icon(Icons.arrow_drop_down),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 bottom: 10,
          //                 right: 10,
          //                 child: FloatingActionButton(
          //                   backgroundColor: mainColor,
          //                   onPressed: () {
          //                     controller.getCurrentLocation();
          //                   },
          //                   child: Icon(Icons.my_location),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
