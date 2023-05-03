import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: AppColors.primary), borderRadius: BorderRadius.circular(16)),
      color: isSelected ? AppColors.primary : Colors.white,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: isSelected ? Colors.white : Colors.black
              ),
            ),
          ),
        ),
      ),
    );
  }

}