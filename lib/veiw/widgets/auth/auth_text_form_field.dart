import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function validator;
  final Widget prefixIcon;
  final String hintText;
  Widget suffixIcon=SizedBox();
  bool obsecureText = false;
  AuthTextFormField({
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.prefixIcon,
    required this.hintText,
    obsecureText,
    suffixIcon,
  }) {
    this.obsecureText = obsecureText ?? false;
    this.suffixIcon = suffixIcon??SizedBox(width: 0,);
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
          color: Colors.black
      ),
      obscureText: obsecureText,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black54,

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)
        ),
      ),
    );
  }
}
