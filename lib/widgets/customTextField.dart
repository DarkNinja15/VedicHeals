// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isObscure;
  final bool isEnabled;
  final TextInputType textInputType;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.isObscure,
    required this.textInputType,
    required this.controller,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: isEnabled,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please enter your $labelText';
          }
          return null;
        },
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: errorColor,
            ),
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        keyboardType: textInputType,
      ),
    );
  }
}
