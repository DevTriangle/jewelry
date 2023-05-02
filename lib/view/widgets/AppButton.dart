import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';

class AppTextButton extends StatelessWidget {
  final Function() onTap;
  final EdgeInsets contentPadding;
  final String label;
  final TextStyle style;
  final TextAlign textAlign;

  const AppTextButton({super.key,
    required this.onTap,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    required this.label,
    this.style = const TextStyle(color: AppColors.primary, fontSize: 16),
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: AppShapes.roundedRectangleShape,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: contentPadding,
          child: Text(
            label,
            style: style,
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}