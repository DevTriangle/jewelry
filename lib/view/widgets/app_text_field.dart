import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';

class AppTextField extends StatelessWidget {
  final Function(String) onChanged;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextStyle hintStyle;
  final EdgeInsets contentPadding;
  final String? prefixText;
  final TextStyle prefixStyle;
  final TextStyle textStyle;
  final TextAlign textAlign;

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
    this.contentPadding = const EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 14),
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.prefixText,
    this.prefixStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black
    ),
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    this.textAlign = TextAlign.start
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      style: textStyle,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cardColor,
        counterText: "",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
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