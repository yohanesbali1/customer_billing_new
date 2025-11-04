import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class CustomFormInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final String? type;
  final bool status;
  final bool isLoading;
  final bool disabled;
  final change_type;
  final String type_keyboard;
  final validator_input_text;

  CustomFormInput({
    required this.placeholder,
    this.status = false,
    this.controller,
    this.isLoading = false,
    this.disabled = true,
    this.type = null,
    this.type_keyboard = 'string',
    this.change_type,
    required this.validator_input_text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        showCursor: true,
        keyboardType: this.type_keyboard == 'number'
            ? TextInputType.number
            : TextInputType.text,
        cursorColor: mainColor,
        enabled: disabled,
        controller: this.controller,
        obscureText: status,
        validator: validator_input_text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.montserrat(
          color: textinputColor,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderboxColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderboxColor, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderboxColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderinputColor, width: 0.5),
          ),
          errorStyle: GoogleFonts.montserrat(
            color: Colors.red,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: this.placeholder,
          hintStyle: GoogleFonts.montserrat(
            color: textSecondaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          suffixIcon: this.change_type != null
              ? IconButton(
                  icon: Icon(
                    status ? Icons.visibility_off : Icons.visibility,
                    color: textSecondaryColor,
                  ),
                  onPressed: () {
                    change_type(!status);
                  },
                )
              : null,
        ),
      ),
    );
  }
}

class CustomFormAreaInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final String? type;
  final bool status;
  final bool isLoading;
  final bool disabled;
  final change_type;
  final validator_input_text;

  CustomFormAreaInput({
    required this.placeholder,
    this.status = false,
    this.controller,
    this.isLoading = false,
    this.type = null,
    this.disabled = false,
    this.change_type,
    required this.validator_input_text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        showCursor: true,
        maxLines: null,
        minLines: 5,
        cursorColor: mainColor,
        controller: this.controller,
        readOnly: disabled || isLoading,
        obscureText: status,
        validator: validator_input_text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.montserrat(
          color: textinputColor,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderboxColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderboxColor, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderboxColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderinputColor, width: 0.5),
          ),
          errorStyle: GoogleFonts.montserrat(
            color: Colors.red,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: this.placeholder,
          hintStyle: GoogleFonts.montserrat(
            color: textSecondaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          suffixIcon: this.change_type != null
              ? IconButton(
                  icon: Icon(
                    status ? Icons.visibility_off : Icons.visibility,
                    color: textSecondaryColor,
                  ),
                  onPressed: () {
                    change_type(!status);
                  },
                )
              : null,
        ),
      ),
    );
  }
}

class CustomFormLabel extends StatelessWidget {
  final name;
  CustomFormLabel(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.name,
        style: GoogleFonts.montserrat(
          color: textPrimaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
