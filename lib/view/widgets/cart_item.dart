import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/model/catalog_item.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';

class CartItem extends StatelessWidget {
  final CatalogItem catalogItem;

  const CartItem({super.key, required this.catalogItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black.withOpacity(0.1))
        )
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: EdgeInsets.zero,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.3),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 120,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    elevation: 0,
                    shape: AppShapes.roundedRectangleShape,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.zero,
                    child: CachedNetworkImage(
                      imageUrl: catalogItem.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(catalogItem.name, style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(catalogItem.shortDesc, style: TextStyle(fontSize: 16, color: AppColors.hintColor)),
                      ],
                    ),
                    Text("${catalogItem.price} ₽", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
