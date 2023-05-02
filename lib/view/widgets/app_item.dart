import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppItem extends StatelessWidget {
  final String imageUrl;
  final String cost;
  final Function() onTap;

  const AppItem({
    super.key,
    required this.imageUrl,
    required this.cost,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.cardColor,
      shape: AppShapes.roundedRectangleShape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: imageUrl
            ),
            SizedBox(height: 5),
            Text(
              cost,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      ),
    );
  }

}