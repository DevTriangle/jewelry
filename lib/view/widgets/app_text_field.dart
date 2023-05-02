import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';

class AppTextField extends StatelessWidget {
  final Function() onChanged;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextStyle hintStyle;
  final EdgeInsets contentPadding;

  const AppTextField({
    super.key,
    required this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText = "",
    this.hintStyle = const TextStyle(
      color: AppColors.hintColor
    ),
    this.contentPadding = const EdgeInsets.all(16)
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cardColor,
        counterText: "",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0
          ),
          borderRadius: AppShapes.borderRadius
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0
            ),
            borderRadius: AppShapes.borderRadius
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0
            ),
            borderRadius: AppShapes.borderRadius
        ),
      ),
    );
  }

}