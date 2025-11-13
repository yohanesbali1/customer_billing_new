import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';

enum FormFieldType { text, number, password, textarea }

class CustomFormField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final FormFieldType type;
  final bool isLoading;
  final bool disabled;
  final String? Function(String?)? validator;

  const CustomFormField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.controller,
    this.type = FormFieldType.text,
    this.isLoading = false,
    this.disabled = false,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final RxBool _obscureText = true.obs;

  bool get isPassword => widget.type == FormFieldType.password;
  bool get isTextarea => widget.type == FormFieldType.textarea;

  TextInputType get keyboardType {
    switch (widget.type) {
      case FormFieldType.number:
        return TextInputType.number;
      case FormFieldType.textarea:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  Widget _buildTextField({required bool obscureText}) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      readOnly: widget.disabled || widget.isLoading,
      maxLines: isTextarea ? null : 1,
      minLines: isTextarea ? 5 : 1,
      keyboardType: keyboardType,
      cursorColor: mainColor,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: GoogleFonts.montserrat(
        color: textinputColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.placeholder,
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
          borderSide: BorderSide(color: borderinputColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderinputColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderinputColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        errorStyle: GoogleFonts.montserrat(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: textSecondaryColor,
                ),
                onPressed: () => _obscureText.toggle(),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final field = isPassword
        ? Obx(() => _buildTextField(obscureText: _obscureText.value))
        : _buildTextField(obscureText: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.montserrat(
              color: textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          field,
        ],
      ),
    );
  }
}
