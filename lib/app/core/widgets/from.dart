import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isEditable;
  final String hintText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  // Dropdown
  final bool isDropdown;
  final List<String>? dropdownItems;
  final String? value;

  // Password & Date
  final bool isPassword;
  final bool isDate;

  // External validation
  final String? errorText;

  final Widget? prefix;

  // Text Area
  final bool isTextArea;
  const CustomInputField({
    Key? key,
    this.controller,
    this.isEditable = true,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.isDropdown = false,
    this.dropdownItems,
    this.value,
    this.isPassword = false,
    this.isDate = false,
    this.errorText,
    this.prefix,
    this.isTextArea = false,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  Future<void> _pickDate() async {
    DateTime initialDate = DateTime.now();

    if (widget.controller?.text.isNotEmpty ?? false) {
      try {
        initialDate = DateFormat('yyyy-MM-dd').parse(widget.controller!.text);
      } catch (_) {}
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      widget.controller?.text = formatted;
      widget.onChanged?.call(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDropdown) {
      return DropdownButtonFormField<String>(
        value: widget.value,
        items: widget.dropdownItems
            ?.map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.barlow(fontSize: 14, color: Colors.white),
                ),
              ),
            )
            .toList(),
        onChanged: (val) {
          if (val != null) widget.onChanged?.call(val);
        },
        hint: Text(
          widget.hintText,
          style: GoogleFonts.barlow(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textinputColor,
          ),
        ),
        dropdownColor: bgsecondColor,
        decoration: _buildDecoration(),
      );
    }

    return TextField(
      controller: widget.controller,
      enabled: widget.isEditable,
      readOnly: widget.isDate,
      keyboardType: widget.isTextArea
          ? TextInputType.multiline
          : widget.keyboardType,
      obscureText: _obscureText,
      onTap: widget.isDate ? _pickDate : null,
      onChanged: widget.onChanged,
      maxLines: widget.isTextArea ? 5 : 1,
      minLines: widget.isTextArea ? 3 : 1,
      style: GoogleFonts.barlow(fontSize: 14, fontWeight: FontWeight.w400),
      decoration: _buildDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.isDate
            ? const Icon(Icons.calendar_today)
            : null,
      ),
    );
  }

  InputDecoration _buildDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      hintText: widget.hintText,
      errorText: widget.errorText, // 🔥 KUNCI EXTERNAL VALIDATION
      hintStyle: GoogleFonts.barlow(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textinputColor,
      ),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      fillColor: Colors.white,
      filled: true,
      prefixIcon: widget.prefix != null
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: widget.prefix,
            )
          : null,

      prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: borderinputColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderinputColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderinputColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
