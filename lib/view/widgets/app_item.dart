import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppItem extends StatelessWidget {
  final String label;
  final String description;
  final String imageUrl;
  final String cost;
  final Function() onTap;

  const AppItem({
    super.key,
    required this.label,
    required this.description,
    required this.imageUrl,
    required this.cost,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.25),
      shape: AppShapes.roundedRectangleShape,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Ink.image(
                          image: CachedNetworkImageProvider(imageUrl),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 12, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintColor),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$cost ₽",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
