import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';

class PaymentCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Function() onClick;

  const PaymentCard(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onClick,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 8),
      shape: AppShapes.roundedRectangleShape,
      color: isSelected ? AppColors.primary : Colors.black.withOpacity(0.1),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Icon(icon,
                size: 16, color: isSelected ? Colors.white : Colors.black),
            SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 14, color: isSelected ? Colors.white : Colors.black))
          ]),
        ),
      ),
    );
  }
}
