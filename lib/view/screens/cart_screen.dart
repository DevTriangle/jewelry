import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jewelry/model/cart_item.dart';
import 'package:jewelry/utils/cart_service.dart';
import 'package:jewelry/view/colors.dart';
import 'package:jewelry/view/screens/order_screen.dart';
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

    setState(() {});

    return cart;
  }

  @override
  Widget build(BuildContext context) {
    print("object");
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Корзина",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    cart.isNotEmpty ? IconButton(
                        onPressed: () {
                          cart.clear();
                          CartService().saveCart(cart);

                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                          size: 20,
                        )) : const SizedBox()
                  ],
                ),
              ),
            ),
            body: FutureBuilder(
                future: getCart,
                builder: (builder, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.isNotEmpty == true) {
                      int sum = 0;

                      for (var c in cart) {
                        sum += c.count * int.parse(c.price);
                      }

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 16),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Итого",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20)),
                                        Text("$sum ₽",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20))
                                      ],
                                    ),
                                    const SizedBox(height: 90),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          cart.isNotEmpty
                              ? PositionedDirectional(
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color: AppColors.primary,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0)),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    OrderScreen(cart: cart)));
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 24),
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
                              : const SizedBox()
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("Коризина пуста!"),
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                })));
  }
}
