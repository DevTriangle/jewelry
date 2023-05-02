import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/model/catalog_item.dart';

class ItemScreen extends StatefulWidget {
  final CatalogItem item;

  const ItemScreen({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => ItemScreenState();
}

class ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            ],
          ),
          ),
          body: Column(
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: widget.item.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      widget.item.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Оценка: ${widget.item.rating}",
                      style: TextStyle(
                          fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "${widget.item.price} ₽",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                    )
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
