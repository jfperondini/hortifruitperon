// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';

import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.readOnly,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Styles.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.white),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.white),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.white),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Styles.grey),
        suffixIcon: suffixIcon,
        contentPadding: Paddings.edgeInsetLeft,
        prefixIcon: prefixIcon,
      ),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (value) {},
    );
  }
}
