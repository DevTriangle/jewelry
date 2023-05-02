import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';

class AppTextField extends StatelessWidget {
  final int maxLines;
  final int minLines;
  final int maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextStyle hintStyle;

  const AppTextField({
    super.key,
    required this.maxLines,
    required this.minLines,
    required this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText = "",
    this.hintStyle = const TextStyle(
      color: AppColors.hintColor
    )
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cardColor,
        counterText: "",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0
          ),
          borderRadius: AppShapes.borderRadius
        )
      ),
    );
  }

}