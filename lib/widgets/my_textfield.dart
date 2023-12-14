import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool txtHidden;
  final IconButton? icon;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    this.txtHidden = false,
    required this.hintText,
    required this.controller,
    required this.textInputType, this.icon, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: txtHidden,
      keyboardType: textInputType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        fillColor: Colors.white,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.black54,
        ),
        suffixIcon: icon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.transparent, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black, width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red, width: 1.5)),
      ),
    );
  }
}
