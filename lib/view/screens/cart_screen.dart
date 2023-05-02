import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jewelry/model/cart_item.dart';
import 'package:jewelry/utils/cart_service.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/widgets/cart_item.dart';

import '../../model/catalog_item.dart';
import '../widgets/app_button.dart';
import 'main_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  List<AppCartItem> cart = [];

  late Future<List<AppCartItem>> getCart;

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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Корзина",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: getCart,
                          builder: (builder, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data?.isNotEmpty == true) {
                                int sum = 0;

                                for (var c in cart) {
                                  sum += c.count * int.parse(c.price);
                                }

                                return Column(
                                  children: [
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: cart.length,
                                        shrinkWrap: true,
                                        itemBuilder: (c, index) {
                                          return CartItem(
                                            cartItem: cart[index],
                                            onDeleteClick: (item) {
                                              setState(() {
                                                cart.remove(item);
                                              });

                                              CartService().saveCart(cart);
                                            },
                                            onChange: (item) {
                                              setState(() {
                                                cart[index] = item;
                                              });

                                              CartService().saveCart(cart);
                                            },
                                          );
                                        }),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Итого",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20)),
                                        Text("$sum ₽",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20))
                                      ],
                                    )
                                  ],
                                );
                              } else {
                                return const Center(
                                  child: Text("Коризина пуста!"),
                                );
                              }
                            } else {
                              return SizedBox();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
            PositionedDirectional(
                bottom: 0, start: 0, end: 0,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: InkWell(
                    onTap: () {

                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Text(
                        "Перейти к оформлению заказа",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
