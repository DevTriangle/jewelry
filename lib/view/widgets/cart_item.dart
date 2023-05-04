import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/model/cart_item.dart';
import 'package:jewelry/model/catalog_item.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/shapes.dart';
import 'package:jewelry/view/widgets/app_button.dart';

class CartItem extends StatelessWidget {
  final AppCartItem cartItem;
  final Function(AppCartItem) onDeleteClick;
  final Function(AppCartItem) onChange;

  const CartItem({super.key, required this.cartItem, required this.onDeleteClick, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 0.5, color: Colors.black.withOpacity(0.1)))),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        margin: EdgeInsets.zero,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.3),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 92,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        elevation: 0,
                        shape: AppShapes.smallRoundedRectangleShape,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.zero,
                        child: CachedNetworkImage(
                          imageUrl: cartItem.image,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItem.name,
                                      style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text(cartItem.description,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.hintColor)),
                                  const SizedBox(height: 4),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "Размер: ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black.withOpacity(0.6)),
                                      ),
                                      TextSpan(
                                        text: "${cartItem.size}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${int.parse(cartItem.price) * cartItem.count} ₽",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      color: Colors.transparent,
                      shape: AppShapes.smallRoundedRectangleShape,
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          onDeleteClick(cartItem);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.remove,
                                color: AppColors.hintColor,
                                size: 18,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Удалить",
                                style: TextStyle(color: AppColors.hintColor),
                              )
                            ],
                          ),
                        ),
                      )),
                  Row(
                    children: [
                      Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          color: Colors.transparent,
                          shape: AppShapes.smallRoundedRectangleShape,
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: cartItem.count > 1 ? () {
                              onChange(AppCartItem(
                                  id: cartItem.id,
                                  name: cartItem.name,
                                  description: cartItem.description,
                                  size: cartItem.size,
                                  count: cartItem.count - 1,
                                  price: cartItem.price,
                                  image: cartItem.image));
                            } : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.remove_rounded,
                                    color: AppColors.hintColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(width: 4),
                      Text(
                        cartItem.count.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.hintColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 4),
                      Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          color: Colors.transparent,
                          shape: AppShapes.smallRoundedRectangleShape,
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              onChange(AppCartItem(
                                  id: cartItem.id,
                                  name: cartItem.name,
                                  description: cartItem.description,
                                  size: cartItem.size,
                                  count: cartItem.count + 1,
                                  price: cartItem.price,
                                  image: cartItem.image));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.add_rounded,
                                    color: AppColors.hintColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
