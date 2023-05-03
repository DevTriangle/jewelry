import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelry/model/catalog_item.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/widgets/app_button.dart';

import '../../model/cart_item.dart';
import '../../utils/cart_service.dart';
import '../widgets/chip.dart';

class ItemScreen extends StatefulWidget {
  final CatalogItem item;

  const ItemScreen({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => ItemScreenState();
}

class ItemScreenState extends State<ItemScreen> {
  List<AppCartItem> cart = [];

  late Future<List<AppCartItem>> getCart;

  String _selectedSize = "";

  @override
  void initState() {
    super.initState();

    getCart = loadCart();
  }

  Future<List<AppCartItem>> loadCart() async {
    var c = await CartService().getCart();

    if (c.isNotEmpty) {
      cart.addAll(c);
    }

    return cart;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
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
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Оценка: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              Builder(builder: (builder) {
                                List<Widget> widgets = [];

                                for (int i = 1; i <= 5; i++) {
                                  if (i <= widget.item.rating) {
                                    widgets.add(
                                      Icon(Icons.star_rounded,
                                          color: Colors.amber),
                                    );
                                  } else {
                                    widgets.add(
                                      Icon(Icons.star_rounded,
                                          color: AppColors.cardColor),
                                    );
                                  }
                                }

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: widgets,
                                );
                              })
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 58,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.item.sizeList.length,
                              itemBuilder: (builder, index) {
                                return AppChip(
                                    label: widget.item.sizeList[index],
                                    onTap: () {
                                      setState(() {
                                        _selectedSize = widget.item.sizeList[index];
                                      });
                                    },
                                    isSelected: _selectedSize == widget.item.sizeList[index]);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                  future: getCart,
                                  builder: (b, snapshot) {
                                    int index = cart.indexWhere((element) => element.id == widget.item.id && element.size == _selectedSize);

                                    return AppButton(
                                      onTap: () {
                                        if (index == -1) {
                                          cart.add(AppCartItem(
                                              id: widget.item.id,
                                              name: widget.item.name,
                                              description: widget.item.shortDesc,
                                              size: _selectedSize,
                                              count: 1,
                                              price: widget.item.price,
                                              image: widget.item.image));
                                        } else {
                                          cart.removeAt(index);
                                        }

                                        CartService().saveCart(cart);

                                        setState(() {});
                                      },
                                      label: index == -1 ? "Добавить в корзину (${widget.item.price} ₽)" : "Убрать из корзины",
                                      contentPadding: EdgeInsets.all(14),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Бренд: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              TextSpan(
                                text: "${widget.item.brand}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ]),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Материал: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              TextSpan(
                                text: "${widget.item.material}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ]),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Вес изделия: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              TextSpan(
                                text: "${widget.item.weight}г",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ]),
                          ),
                          SizedBox(height: 16),
                          Text(
                            widget.item.description,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                height: 1.3),
                          ),
                          SizedBox(height: 16),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Категории: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              TextSpan(
                                text: widget.item.categories
                                    .toString()
                                    .replaceAll(RegExp(r'\[*\]*'), ""),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Card(
                  margin: EdgeInsets.all(8),
                  elevation: 0,
                  color: Colors.black.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
