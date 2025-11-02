import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/core/theme/theme.dart';
import 'package:customer_billing/app/core/widgets/form.dart';
import 'package:customer_billing/app/modules/help/help_add_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class FormHelpPage extends StatelessWidget {
  final controller = Get.find<HelpFormController>();

  @override
  Widget build(BuildContext context) {
    void showDialog(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(top: false, child: child),
        ),
      );
    }

    void showModalMenuCamera() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Ambil Dari Kamera",
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.camera);
                  },
                ),
                Divider(height: 0.5, thickness: 0.5, color: borderboxColor),
                ListTile(
                  title: Text(
                    "Ambil Dari Galeri",
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    void _showSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // ini penting!
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(
                context,
              ).viewInsets.bottom, // untuk menghindari keyboard
            ),
            child: SingleChildScrollView(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Cari Lokasi',
                        style: GoogleFonts.montserrat(
                          color: textinputColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        showCursor: true,
                        initialValue: controller.search.value,
                        cursorColor: mainColor,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: GoogleFonts.montserrat(
                          color: textinputColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: borderboxColor,
                              width: 0.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: borderboxColor,
                              width: 0.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.5,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: borderboxColor,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: borderinputColor,
                              width: 0.5,
                            ),
                          ),
                          errorStyle: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Cari..',
                          hintStyle: GoogleFonts.montserrat(
                            color: textSecondaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) {
                          controller.search.value = value;
                        },
                      ),
                      Container(
                        height: 200,
                        padding: const EdgeInsets.only(top: 10),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.searchItem.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              controller.updateLocation(
                                LatLng(
                                  controller.searchItem[index].lat,
                                  controller.searchItem[index].lon,
                                ),
                              );
                              controller.search.value =
                                  controller.searchItem[index].display_name;
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12,
                              ),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                controller.searchItem[index].display_name,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Kembali',
          style: GoogleFonts.montserrat(
            color: textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Form Bantuan",
                    style: monseratTextFont.copyWith(
                      color: textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Lengkapi form berikut",
                    style: monseratTextFont.copyWith(
                      color: textPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: controller.formkey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel('Tipe Gangguan'),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showDialog(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => CupertinoPicker(
                                        magnification: 1.22,
                                        squeeze: 1.2,
                                        useMagnifier: true,
                                        itemExtent: 32,
                                        // This sets the initial item.
                                        scrollController:
                                            FixedExtentScrollController(
                                              initialItem:
                                                  controller.type_topic_select,
                                            ),
                                        // This is called when selected item is changed.
                                        onSelectedItemChanged:
                                            (int selectedItem) {
                                              controller.type_topic_select =
                                                  selectedItem;
                                            },
                                        children: controller.type_topic_data
                                            .map((item) {
                                              return Center(
                                                child: Text(
                                                  item.type,
                                                  style: GoogleFonts.montserrat(
                                                    color: textPrimaryColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              );
                                            })
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 24),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        controller.select_type_data();
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 20,
                                        ),
                                      ),
                                      child: Text(
                                        'Simpan',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: CustomFormInput(
                            isLoading: controller.isLoading.value,
                            placeholder: '',
                            disabled: false,
                            validator_input_text: controller.validator_input,
                            controller: controller.type_topic_id.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel('Permasalahan'),
                        Obx(
                          () => CustomFormAreaInput(
                            isLoading: controller.isLoading.value,
                            placeholder: '',
                            validator_input_text: controller.validator_input,
                            controller: controller.description.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel('No HP'),
                        Obx(
                          () => CustomFormInput(
                            isLoading: controller.isLoading.value,
                            placeholder: '',
                            type_keyboard: 'number',
                            validator_input_text: controller.validator_input,
                            controller: controller.phone.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormLabel('Alamat'),
                        Obx(
                          () => CustomFormAreaInput(
                            isLoading: controller.isLoading.value,
                            placeholder: '',
                            validator_input_text: controller.validator_input,
                            controller: controller.address.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomFormLabel('Gambar'),
                        SizedBox(height: 10),
                        Obx(
                          () => Container(
                            height: 250,
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: borderboxColor,
                                width: 0.5,
                              ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              showModalMenuCamera();
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
                        CustomFormLabel('Map'),
                        Obx(() {
                          return SizedBox(
                            height: 300,
                            child: Stack(
                              children: <Widget>[
                                FlutterMap(
                                  mapController:
                                      controller.flutterMapController,
                                  options: MapOptions(
                                    initialCenter: LatLng(
                                      -8.6524973,
                                      115.2191175,
                                    ),
                                    interactionOptions: InteractionOptions(
                                      enableMultiFingerGestureRace: false,
                                      flags:
                                          InteractiveFlag.all &
                                          ~InteractiveFlag.rotate,
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
                                    if (controller.selectedLocation.value !=
                                        null)
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point: controller
                                                .selectedLocation
                                                .value!,
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
                                        return controller.isLoading.value
                                            ? null
                                            : _showSheet(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
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
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.formkey.currentState!.validate() &&
                      controller.selectedLocation.value != null) {
                    FocusScope.of(context).unfocus();
                    await controller.submit_data();
                  } else {
                    Helper().AlertGetX(
                      null,
                      'Cek kembali data yang anda masukkan',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "Simpan",
                  style: monseratTextFont.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
