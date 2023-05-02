import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jewelry/utils/cart_service.dart';
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
  List<CatalogItem> cart = [];

  late Future<List<CatalogItem>> getCart;

  @override
  void initState() {
    super.initState();

    getCart = loadCart();
  }

  Future<List<CatalogItem>> loadCart() async {
    cart.addAll(await CartService().getCart());

    cart.add(CatalogItem(
        id: 1,
        name: "name",
        shortDesc: "shortDesc",
        description: "description",
        price: "20000",
        categories: [],
        brand: "brand",
        weight: 20,
        material: "material",
        image:
            "https://www.gold-fenix.ru/upload/iblock/8d4/c1nkn79xawyfh8q06ao33xnfe45dunhd.jpg",
        rating: 5));

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
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
          child: Column(
            children: [
              FutureBuilder(
                  future: getCart,
                  builder: (builder, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.isNotEmpty == true) {
                        return Expanded(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: cart.length,
                              itemBuilder: (c, index) {
                                return CartItem(catalogItem: cart[index]);
                              }),
                        );
                      } else {
                        return const Center(
                          child: Text("Коризина пуста!"),
                        );
                      }
                    } else {
                      return Text("data");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
