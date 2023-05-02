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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.4,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      widget.item.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Оценка: ${widget.item.rating}",
                      style: TextStyle(
                          fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "${widget.item.price} ₽",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Бренд: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6)
                              ),
                            ),
                            TextSpan(
                              text: "${widget.item.brand}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          ]
                        ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Материал: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)
                              ),
                            ),
                            TextSpan(
                              text: "${widget.item.material}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Вес изделия: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)
                              ),
                            ),
                            TextSpan(
                              text: "${widget.item.weight}г",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.item.description,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        height: 1.3
                      ),
                    ),
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Категории: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)
                              ),
                            ),
                            TextSpan(
                              text: widget.item.categories.toString().replaceAll(RegExp(r'\[*\]*'), ""),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
