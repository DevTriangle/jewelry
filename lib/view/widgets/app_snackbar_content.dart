import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackBarContent extends StatelessWidget {
  final String label;
  final IconData icon;

  const AppSnackBarContent({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),
        Text(label, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center,)
      ],
    );
  }
}