import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';

enum FormFieldType { text, number, password, textarea }

class CustomFormField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final FormFieldType type;
  final bool isLoading;
  final bool disabled;
  final String? Function(String?)? validator;

  /// Internal for password toggle
  final RxBool _obscureText = true.obs;

  CustomFormField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.controller,
    this.type = FormFieldType.text,
    this.isLoading = false,
    this.disabled = false,
    this.validator,
  }) : super(key: key);

  bool get isPassword => type == FormFieldType.password;
  bool get isTextarea => type == FormFieldType.textarea;

  TextInputType get keyboardType {
    switch (type) {
      case FormFieldType.number:
        return TextInputType.number;
      case FormFieldType.textarea:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Obx(
            () => TextFormField(
              controller: controller,
              obscureText: isPassword ? _obscureText.value : false,
              readOnly: disabled || isLoading,
              maxLines: isTextarea ? null : 1,
              minLines: isTextarea ? 5 : 1,
              keyboardType: keyboardType,
              cursorColor: mainColor,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: GoogleFonts.montserrat(
                color: textinputColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: placeholder,
                hintStyle: GoogleFonts.montserrat(
                  color: textSecondaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderboxColor, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderboxColor, width: 0.5),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderboxColor, width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderinputColor, width: 0.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red, width: 0.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red, width: 0.5),
                ),
                errorStyle: GoogleFonts.montserrat(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: textSecondaryColor,
                        ),
                        onPressed: () {
                          _obscureText.value = !_obscureText.value;
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
